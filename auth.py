from flask import Blueprint, request, jsonify
from src.models.user import db, User
from datetime import datetime
import jwt
import os

auth_bp = Blueprint('auth', __name__)

SECRET_KEY = os.environ.get('SECRET_KEY', 'asdf#FGSgvasgf$5$WGT')

def generate_token(user_id):
    """إنشاء رمز JWT للمستخدم"""
    import time
    payload = {
        'user_id': user_id,
        'exp': time.time() + 86400  # صالح لمدة 24 ساعة
    }
    return jwt.encode(payload, SECRET_KEY, algorithm='HS256')

def verify_token(token):
    """التحقق من صحة رمز JWT"""
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=['HS256'])
        return payload['user_id']
    except jwt.ExpiredSignatureError:
        return None
    except jwt.InvalidTokenError:
        return None

@auth_bp.route('/register', methods=['POST'])
def register():
    """تسجيل مستخدم جديد"""
    try:
        data = request.get_json()
        
        # التحقق من البيانات المطلوبة
        if not data or not all(k in data for k in ('username', 'email', 'password')):
            return jsonify({'error': 'البيانات المطلوبة مفقودة'}), 400
        
        username = data['username'].strip()
        email = data['email'].strip().lower()
        password = data['password']
        role = data.get('role', 'buyer')
        
        # التحقق من صحة البيانات
        if len(username) < 3:
            return jsonify({'error': 'اسم المستخدم يجب أن يكون 3 أحرف على الأقل'}), 400
        
        if len(password) < 6:
            return jsonify({'error': 'كلمة المرور يجب أن تكون 6 أحرف على الأقل'}), 400
        
        if '@' not in email:
            return jsonify({'error': 'البريد الإلكتروني غير صحيح'}), 400
        
        if role not in ['buyer', 'seller', 'admin']:
            return jsonify({'error': 'نوع الحساب غير صحيح'}), 400
        
        # التحقق من عدم وجود المستخدم مسبقاً
        if User.query.filter_by(username=username).first():
            return jsonify({'error': 'اسم المستخدم موجود مسبقاً'}), 400
        
        if User.query.filter_by(email=email).first():
            return jsonify({'error': 'البريد الإلكتروني موجود مسبقاً'}), 400
        
        # إنشاء المستخدم الجديد
        user = User(
            username=username,
            email=email,
            role=role,
            seller_since=datetime.utcnow() if role == 'seller' else None
        )
        user.set_password(password)
        
        db.session.add(user)
        db.session.commit()
        
        # إنشاء رمز المصادقة
        token = generate_token(user.id)
        
        return jsonify({
            'message': 'تم إنشاء الحساب بنجاح',
            'token': token,
            'user': user.to_dict()
        }), 201
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': f'خطأ في الخادم: {str(e)}'}), 500

@auth_bp.route('/login', methods=['POST'])
def login():
    """تسجيل دخول المستخدم"""
    try:
        data = request.get_json()
        
        if not data or not all(k in data for k in ('email', 'password')):
            return jsonify({'error': 'البيانات المطلوبة مفقودة'}), 400
        
        email = data['email'].strip().lower()
        password = data['password']
        
        # البحث عن المستخدم
        user = User.query.filter_by(email=email).first()
        
        if not user or not user.check_password(password):
            return jsonify({'error': 'البريد الإلكتروني أو كلمة المرور غير صحيحة'}), 401
        
        if not user.is_active:
            return jsonify({'error': 'الحساب معطل'}), 401
        
        # إنشاء رمز المصادقة
        token = generate_token(user.id)
        
        return jsonify({
            'message': 'تم تسجيل الدخول بنجاح',
            'token': token,
            'user': user.to_dict()
        }), 200
        
    except Exception as e:
        return jsonify({'error': f'خطأ في الخادم: {str(e)}'}), 500

@auth_bp.route('/profile', methods=['GET'])
def get_profile():
    """الحصول على ملف المستخدم الشخصي"""
    try:
        # الحصول على رمز المصادقة
        auth_header = request.headers.get('Authorization')
        if not auth_header or not auth_header.startswith('Bearer '):
            return jsonify({'error': 'رمز المصادقة مطلوب'}), 401
        
        token = auth_header.split(' ')[1]
        user_id = verify_token(token)
        
        if not user_id:
            return jsonify({'error': 'رمز المصادقة غير صحيح'}), 401
        
        user = User.query.get(user_id)
        if not user:
            return jsonify({'error': 'المستخدم غير موجود'}), 404
        
        return jsonify({'user': user.to_dict()}), 200
        
    except Exception as e:
        return jsonify({'error': f'خطأ في الخادم: {str(e)}'}), 500

@auth_bp.route('/profile', methods=['PUT'])
def update_profile():
    """تحديث ملف المستخدم الشخصي"""
    try:
        # التحقق من المصادقة
        auth_header = request.headers.get('Authorization')
        if not auth_header or not auth_header.startswith('Bearer '):
            return jsonify({'error': 'رمز المصادقة مطلوب'}), 401
        
        token = auth_header.split(' ')[1]
        user_id = verify_token(token)
        
        if not user_id:
            return jsonify({'error': 'رمز المصادقة غير صحيح'}), 401
        
        user = User.query.get(user_id)
        if not user:
            return jsonify({'error': 'المستخدم غير موجود'}), 404
        
        data = request.get_json()
        if not data:
            return jsonify({'error': 'البيانات مطلوبة'}), 400
        
        # تحديث البيانات
        if 'username' in data:
            username = data['username'].strip()
            if len(username) < 3:
                return jsonify({'error': 'اسم المستخدم يجب أن يكون 3 أحرف على الأقل'}), 400
            
            # التحقق من عدم وجود اسم المستخدم مسبقاً
            existing_user = User.query.filter_by(username=username).first()
            if existing_user and existing_user.id != user.id:
                return jsonify({'error': 'اسم المستخدم موجود مسبقاً'}), 400
            
            user.username = username
        
        if 'email' in data:
            email = data['email'].strip().lower()
            if '@' not in email:
                return jsonify({'error': 'البريد الإلكتروني غير صحيح'}), 400
            
            # التحقق من عدم وجود البريد الإلكتروني مسبقاً
            existing_user = User.query.filter_by(email=email).first()
            if existing_user and existing_user.id != user.id:
                return jsonify({'error': 'البريد الإلكتروني موجود مسبقاً'}), 400
            
            user.email = email
        
        user.updated_at = datetime.utcnow()
        db.session.commit()
        
        return jsonify({
            'message': 'تم تحديث الملف الشخصي بنجاح',
            'user': user.to_dict()
        }), 200
        
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': f'خطأ في الخادم: {str(e)}'}), 500

def require_auth(f):
    """ديكوريتر للتحقق من المصادقة"""
    from functools import wraps
    
    @wraps(f)
    def decorated_function(*args, **kwargs):
        auth_header = request.headers.get('Authorization')
        if not auth_header or not auth_header.startswith('Bearer '):
            return jsonify({'error': 'رمز المصادقة مطلوب'}), 401
        
        token = auth_header.split(' ')[1]
        user_id = verify_token(token)
        
        if not user_id:
            return jsonify({'error': 'رمز المصادقة غير صحيح'}), 401
        
        user = User.query.get(user_id)
        if not user:
            return jsonify({'error': 'المستخدم غير موجود'}), 404
        
        # إضافة المستخدم للطلب
        request.current_user = user
        return f(*args, **kwargs)
    
    return decorated_function

def require_role(role):
    """ديكوريتر للتحقق من دور المستخدم"""
    def decorator(f):
        from functools import wraps
        
        @wraps(f)
        def decorated_function(*args, **kwargs):
            if not hasattr(request, 'current_user'):
                return jsonify({'error': 'المصادقة مطلوبة'}), 401
            
            user = request.current_user
            if role == 'seller' and not user.is_seller:
                return jsonify({'error': 'يجب أن تكون بائعاً للوصول لهذه الميزة'}), 403
            elif role == 'admin' and not user.is_admin:
                return jsonify({'error': 'يجب أن تكون مديراً للوصول لهذه الميزة'}), 403
            
            return f(*args, **kwargs)
        
        return decorated_function
    return decorator

