# مشروع Soqaly - منصة التجارة الإلكترونية

## نظرة عامة
Soqaly هو مشروع منصة تجارة إلكترونية متكامل يتكون من:
- **Backend**: خادم Flask API مع قاعدة بيانات SQLite
- **Frontend**: تطبيق Flutter للهواتف المحمولة والويب

## هيكل المشروع
```
soqaly_project/
├── backend/                 # خادم Flask API
│   ├── src/
│   │   ├── models/         # نماذج قاعدة البيانات
│   │   ├── routes/         # مسارات API
│   │   ├── database/       # قاعدة البيانات
│   │   └── main.py         # الملف الرئيسي
│   ├── requirements.txt    # متطلبات Python
│   └── venv/              # البيئة الافتراضية
├── frontend/               # تطبيق Flutter
│   ├── lib/               # كود Dart
│   ├── assets/            # الموارد (صور، خطوط)
│   ├── web/               # ملفات الويب
│   └── pubspec.yaml       # متطلبات Flutter
└── README.md              # هذا الملف
```

## الميزات الرئيسية

### Backend (Flask API)
- **المصادقة والتفويض**: تسجيل الدخول والخروج مع JWT
- **إدارة المستخدمين**: مشترين، بائعين، مديرين
- **إدارة المنتجات**: إضافة، تعديل، حذف المنتجات
- **إدارة الفئات**: تصنيف المنتجات
- **إدارة الطلبات**: معالجة الطلبات والعمولات
- **CORS**: دعم الطلبات من مصادر مختلفة

### Frontend (Flutter)
- **واجهة مستخدم حديثة**: تصميم متجاوب للهواتف والويب
- **إدارة الحالة**: استخدام Provider
- **التنقل**: Go Router للتنقل السلس
- **الصور**: معالجة وعرض الصور
- **المدفوعات**: دعم المدفوعات الرقمية

## متطلبات التشغيل

### Backend
- Python 3.8+
- Flask 3.1.1
- SQLAlchemy 2.0.41
- PyJWT 2.10.1
- Flask-CORS 6.0.0

### Frontend
- Flutter SDK 3.0.0+
- Dart SDK
- Android Studio / VS Code

## التثبيت والتشغيل

### تشغيل Backend
```bash
cd backend
python -m venv venv
source venv/bin/activate  # Linux/Mac
# أو
venv\\Scripts\\activate   # Windows
pip install -r requirements.txt
python src/main.py
```

### تشغيل Frontend
```bash
cd frontend
flutter pub get
flutter run -d web  # للويب
flutter run         # للهاتف
```

## API Endpoints

### المصادقة
- `POST /api/register` - تسجيل مستخدم جديد
- `POST /api/login` - تسجيل الدخول
- `GET /api/profile` - الحصول على الملف الشخصي
- `PUT /api/profile` - تحديث الملف الشخصي

### المستخدمين (للمديرين)
- `GET /api/users` - قائمة المستخدمين
- `GET /api/users/{id}` - تفاصيل مستخدم
- `PUT /api/users/{id}/toggle-status` - تفعيل/إلغاء تفعيل
- `PUT /api/users/{id}/role` - تغيير الدور
- `GET /api/users/stats` - إحصائيات المستخدمين

### المنتجات
- `GET /api/products` - قائمة المنتجات
- `POST /api/products` - إضافة منتج جديد
- `GET /api/products/{id}` - تفاصيل منتج
- `PUT /api/products/{id}` - تحديث منتج
- `DELETE /api/products/{id}` - حذف منتج

### الفئات
- `GET /api/categories` - قائمة الفئات
- `POST /api/categories` - إضافة فئة جديدة
- `PUT /api/categories/{id}` - تحديث فئة
- `DELETE /api/categories/{id}` - حذف فئة

## قاعدة البيانات

### الجداول الرئيسية
- **users**: المستخدمين (مشترين، بائعين، مديرين)
- **categories**: فئات المنتجات
- **products**: المنتجات
- **orders**: الطلبات
- **order_items**: عناصر الطلبات
- **commissions**: العمولات

### البيانات الافتراضية
- **المدير الافتراضي**: admin@soqaly.com / admin123
- **الفئات الأساسية**: الملابس، الأجهزة الإلكترونية، الأدوات المنزلية، الكتب والقرطاسية

## الأمان
- تشفير كلمات المرور باستخدام bcrypt
- مصادقة JWT للحماية
- تحقق من الأدوار والصلاحيات
- حماية CORS مُكونة بشكل صحيح

## التطوير والمساهمة
1. Fork المشروع
2. إنشاء branch جديد للميزة
3. Commit التغييرات
4. Push إلى Branch
5. إنشاء Pull Request

## الترخيص
هذا المشروع مرخص تحت رخصة MIT

## الدعم
للدعم والاستفسارات، يرجى التواصل عبر:
- البريد الإلكتروني: support@soqaly.com
- GitHub Issues

---
تم تطوير هذا المشروع بواسطة فريق Soqaly

