# 🛒 MyStore - متجر إلكتروني (نسخة اختبار أمني)

<div align="center">

![Django](https://img.shields.io/badge/Django-6.0.1-green?style=for-the-badge&logo=django)
![Python](https://img.shields.io/badge/Python-3.12-blue?style=for-the-badge&logo=python)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-purple?style=for-the-badge&logo=bootstrap)
![Security](https://img.shields.io/badge/Security-30_VULNERABILITIES-red?style=for-the-badge&logo=security)
![OWASP](https://img.shields.io/badge/OWASP-Top_10_2021-orange?style=for-the-badge)

**مشروع تخرج لدراسة ومقارنة أدوات فحص الأمان (SAST/DAST/AI)**

**يحتوي على 30 ثغرة أمنية متعمدة من OWASP Top 10**

[⚠️ تحذير أمني](#-تحذير-أمني) • [🚀 التثبيت](#-التثبيت) • [🔍 الثغرات](#-قائمة-الثغرات) • [📖 التوثيق](#-التوثيق)

</div>

---

## ⚠️ تحذير أمني مهم

<div align="center">

### 🚨 هذه النسخة مُعدة للاختبار الأمني فقط 🚨

</div>

> **تنبيه:** هذا المشروع يحتوي على **30 ثغرة أمنية متعمدة** لأغراض الاختبار والدراسة الأكاديمية.

### ❌ لا تستخدم هذا المشروع في:
- بيئات الإنتاج (Production)
- التعامل مع بيانات حقيقية
- معالجة مدفوعات حقيقية
- أي استخدام تجاري أو على الإنترنت

### 🎯 الغرض من هذا المشروع:
- ✅ اختبار ومقارنة أدوات فحص الثغرات (SAST/DAST/AI)
- ✅ التعلم والدراسة الأكاديمية
- ✅ فهم ثغرات OWASP Top 10 2021
- ✅ تدريب على اكتشاف ومعالجة الثغرات

### 🔍 الثغرات المتضمنة:
| نوع الثغرة | العدد | الخطورة |
|-----------|------|---------|
| **SQL Injection** | 6 | 🔴 Critical |
| **Command Injection** | 2 | 🔴 Critical |
| **Code Injection** | 2 | 🔴 Critical |
| **Insecure Deserialization** | 2 | 🔴 Critical |
| **XSS (Reflected & Stored)** | 2 | 🟡 Medium |
| **Path Traversal** | 2 | 🟠 High |
| **IDOR** | 3 | 🟠 High |
| **CSRF** | 2 | 🟡 Medium |
| **Information Disclosure** | 4 | 🔴 Critical |
| **XXE** | 1 | 🟠 High |
| **Access Control** | 3 | 🔴 Critical |
| **Misconfiguration** | 3 | 🟠 High |

**إجمالي:** 30 ثغرة (14 Critical, 10 High, 6 Medium)

---

## 📖 نظرة عامة

MyStore هو متجر إلكتروني تجريبي مبني بـ Django. تم تصميمه كجزء من مشروع تخرج لاختبار ومقارنة أدوات فحص الثغرات الأمنية. **هذه النسخة تحتوي على ثغرات أمنية متعمدة ولا يجب استخدامها في بيئات حقيقية.**

---

## 🚀 التثبيت

```bash
# استنساخ المشروع
git clone https://github.com/BaderHalimi/eng-final-project.git
cd eng-final-project

# إنشاء بيئة افتراضية
python -m venv venv
source venv/bin/activate  # Linux/Mac
# أو
venv\Scripts\activate  # Windows

# تثبيت المتطلبات
pip install -r requirements.txt

# إعداد المتغيرات البيئية
# انسخ ملف .env.example إلى .env وقم بتعديل القيم
cp .env.example .env
# قم بتوليد SECRET_KEY جديد:
# python -c 'import secrets; print(secrets.token_urlsafe(50))'
# ثم ضعه في DJANGO_SECRET_KEY في ملف .env

# إعداد قاعدة البيانات
python manage.py migrate

# إنشاء بيانات تجريبية
python manage.py create_sample_data

# إنشاء مستخدم مسؤول
python manage.py createsuperuser

# تشغيل الخادم
python manage.py runserver
```

---

## 📖 الميزات

### 🛍️ ميزات المتجر
- ✅ عرض المنتجات والتصنيفات
- ✅ سلة التسوق
- ✅ قائمة الأمنيات (Wishlist)
- ✅ نظام الطلبات
- ✅ كوبونات الخصم
- ✅ لوحة تحكم مخصصة

### 👤 ميزات المستخدم
- ✅ تسجيل وتسجيل دخول
- ✅ إدارة الملف الشخصي
- ✅ إدارة العناوين
- ✅ تتبع الطلبات

### 🎨 التصميم
- ✅ Bootstrap 5 RTL
- ✅ تصميم عربي متجاوب
- ✅ Bootstrap Icons

---

## � قائمة الثغرات

### إجمالي الثغرات: 30 ثغرة

#### 🔴 Critical (14 ثغرة)
- GT-01: SQL Injection in user search
- GT-02: Insecure Deserialization via Pickle
- GT-06: Broken Access Control - Admin Actions
- GT-07: SQL Injection in Product Search
- GT-10: Command Injection in Report
- GT-12: Server-Side Template Injection (SSTI)
- GT-13: SQL Injection in Order Search
- GT-15: Insecure YAML Deserialization
- GT-19: SQL Injection in Dashboard
- GT-20: Command Injection in Backup
- GT-22: Missing Authentication in Bulk Delete
- GT-23: System Info Disclosure
- GT-24: Code Injection via eval()
- GT-25: SQL Injection in Cart Discount
- GT-28: Hardcoded Secret Key

#### 🟠 High (10 ثغرات)
- GT-03: Sensitive Data Exposure
- GT-04: CSRF + IDOR in Email Update
- GT-09: Path Traversal in Product Image
- GT-14: XXE - XML External Entity Injection
- GT-16: IDOR in Order Invoice
- GT-17: Mass Assignment
- GT-18: Information Disclosure - Export Orders
- GT-21: Path Traversal in Logs
- GT-29: Debug Mode Enabled

#### 🟡 Medium (6 ثغرات)
- GT-05: Weak Cryptographic Algorithm (MD5)
- GT-08: Reflected XSS
- GT-11: Stored XSS
- GT-26: CSRF in Cart Update
- GT-27: IDOR in Cart Details
- GT-30: Insecure Cookie Configuration

📖 **لمزيد من التفاصيل:** انظر [VULNERABILITIES.md](VULNERABILITIES.md)

---

## 📚 التوثيق

| الملف | الوصف |
|------|-------|
| 📋 [VULNERABILITIES.md](VULNERABILITIES.md) | توثيق مفصل لكل ثغرة |
| 🧪 [TESTING_GUIDE.md](TESTING_GUIDE.md) | دليل اختبار الثغرات |
| 📊 [IMPLEMENTATION_STATUS.md](IMPLEMENTATION_STATUS.md) | حالة تنفيذ الثغرات |
| 🗂️ [data/ground_truth/ground_truth_v1.json](data/ground_truth/ground_truth_v1.json) | قاعدة بيانات الثغرات |
| 🔒 [SECURITY.md](SECURITY.md) | سياسة الأمان |

---

## 🚀 البدء السريع

### 1. تشغيل السيرفر
```bash
python manage.py migrate
python manage.py runserver
```

### 2. اختبار الثغرات
```bash
# اختبار تلقائي لجميع الثغرات
./test_vulnerabilities.sh

# اختبار ثغرة محددة
curl "http://localhost:8000/accounts/api/users/search/?q=' OR '1'='1"
```

### 3. فحص بأدوات SAST
```bash
# Bandit
bandit -r . -f json -o bandit-report.json

# Semgrep
semgrep --config=auto --json .
```

---

## 🎯 الغرض من المشروع

هذا المشروع مُصمم لـ:

1. **🔍 اختبار أدوات SAST** - تحليل الكود الثابت (Bandit, Semgrep, SonarQube)
2. **🌐 اختبار أدوات DAST** - اختبار ديناميكي (OWASP ZAP, Burp Suite, SQLMap)
3. **🤖 اختبار أدوات AI** - تحليل بالذكاء الاصطناعي (Snyk, GitHub Copilot)
4. **📈 مقارنة النتائج** - تحديد أفضل الأدوات في اكتشاف الثغرات

---

## 📜 الترخيص

مشروع تخرج - جميع الحقوق محفوظة © 2026

---

<div align="center">

**صُنع بـ ❤️ لمشروع التخرج**

⭐ إذا أعجبك المشروع، لا تنسَ النجمة!

</div>
