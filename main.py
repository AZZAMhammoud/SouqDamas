import os
import sys
# DON'T CHANGE THIS !!!
sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))

from flask import Flask, send_from_directory
from flask_cors import CORS
from src.models.user import db
from src.models.product import Product, Category
from src.models.order import Order, OrderItem, Commission
from src.routes.user import user_bp
from src.routes.auth import auth_bp
from src.routes.products import products_bp
from src.routes.categories import categories_bp

app = Flask(__name__, static_folder=os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'frontend', 'build', 'web'))
app.config['SECRET_KEY'] = 'asdf#FGSgvasgf$5$WGT'

# تمكين CORS للسماح بالطلبات من الواجهة الأمامية
CORS(app, origins="*")

# تسجيل المسارات
app.register_blueprint(user_bp, url_prefix='/api')
app.register_blueprint(auth_bp, url_prefix='/api')
app.register_blueprint(products_bp, url_prefix='/api')
app.register_blueprint(categories_bp, url_prefix='/api')

# إعداد قاعدة البيانات
app.config['SQLALCHEMY_DATABASE_URI'] = f"sqlite:///{os.path.join(os.path.dirname(__file__), 'database', 'app.db')}"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

def init_database():
    """تهيئة قاعدة البيانات مع البيانات الأولية"""
    with app.app_context():
        db.create_all()
        
        # إضافة الفئات الأساسية إذا لم تكن موجودة
        if Category.query.count() == 0:
            categories = [
                Category(name='الملابس', description='ملابس رجالية ونسائية وأطفال', icon_url='👕'),
                Category(name='الأجهزة الإلكترونية', description='هواتف، حاسوب، تلفزيون', icon_url='📱'),
                Category(name='الأدوات المنزلية', description='أثاث، أدوات مطبخ، ديكور', icon_url='🏠'),
                Category(name='الكتب والقرطاسية', description='كتب، مجلات، أدوات مكتبية', icon_url='📚')
            ]
            
            for category in categories:
                db.session.add(category)
            
            db.session.commit()
            print("تم إضافة الفئات الأساسية")
        
        # إضافة مدير افتراضي إذا لم يكن موجوداً
        from src.models.user import User
        if not User.query.filter_by(role='admin').first():
            admin = User(
                username='admin',
                email='admin@soqaly.com',
                role='admin'
            )
            admin.set_password('admin123')
            db.session.add(admin)
            db.session.commit()
            print("تم إضافة المدير الافتراضي: admin@soqaly.com / admin123")

# تهيئة قاعدة البيانات
init_database()

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve(path):
    static_folder_path = app.static_folder
    if static_folder_path is None:
            return "Static folder not configured", 404

    if path != "" and os.path.exists(os.path.join(static_folder_path, path)):
        return send_from_directory(static_folder_path, path)
    else:
        index_path = os.path.join(static_folder_path, 'index.html')
        if os.path.exists(index_path):
            return send_from_directory(static_folder_path, 'index.html')
        else:
            return "index.html not found", 404

# مسار للتحقق من حالة الخادم
@app.route('/api/health', methods=['GET'])
def health_check():
    return {'status': 'ok', 'message': 'Soqaly API is running'}, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)



