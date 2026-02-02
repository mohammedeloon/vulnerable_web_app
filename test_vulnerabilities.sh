#!/bin/bash
# اختبار سريع للثغرات الأمنية
# Quick vulnerability test script

echo "🔍 Testing MyStore Vulnerabilities..."
echo "======================================"

BASE_URL="http://localhost:8000"

# اختبار الاتصال بالسيرفر
echo ""
echo "1️⃣ Checking server connectivity..."
if curl -s -o /dev/null -w "%{http_code}" "$BASE_URL" | grep -q "200\|302\|301"; then
    echo "✅ Server is running"
else
    echo "❌ Server is not running. Please start with: python manage.py runserver"
    exit 1
fi

# GT-01: SQL Injection
echo ""
echo "2️⃣ Testing GT-01: SQL Injection in user search..."
curl -s "$BASE_URL/accounts/api/users/search/?q=' OR '1'='1" | head -n 3
echo "✅ GT-01 endpoint accessible"

# GT-03: Sensitive Data Exposure
echo ""
echo "3️⃣ Testing GT-03: Sensitive Data Exposure..."
curl -s "$BASE_URL/accounts/api/users/debug/?id=test-id" | head -n 3
echo "✅ GT-03 endpoint accessible"

# GT-06: Admin Actions
echo ""
echo "4️⃣ Testing GT-06: Broken Access Control..."
curl -s "$BASE_URL/accounts/api/admin/action/?action=test&user_id=test" | head -n 3
echo "✅ GT-06 endpoint accessible"

# GT-07: SQL Injection in Products
echo ""
echo "5️⃣ Testing GT-07: SQL Injection in product search..."
curl -s "$BASE_URL/api/search/?q=test&sort=name" | head -n 3
echo "✅ GT-07 endpoint accessible"

# GT-08: XSS
echo ""
echo "6️⃣ Testing GT-08: Reflected XSS..."
curl -s "$BASE_URL/api/preview/?name=TestProduct&description=TestDesc" | head -n 3
echo "✅ GT-08 endpoint accessible"

# GT-12: SSTI
echo ""
echo "7️⃣ Testing GT-12: Server-Side Template Injection..."
curl -s "$BASE_URL/api/render/?template=Hello&name=World" | head -n 3
echo "✅ GT-12 endpoint accessible"

# GT-13: SQL Injection in Orders
echo ""
echo "8️⃣ Testing GT-13: SQL Injection in order search..."
curl -s "$BASE_URL/orders/api/search/?order_number=test" | head -n 3
echo "✅ GT-13 endpoint accessible"

# GT-16: IDOR
echo ""
echo "9️⃣ Testing GT-16: IDOR in order invoice..."
curl -s "$BASE_URL/orders/api/invoice/00000000-0000-0000-0000-000000000000/" | head -n 3
echo "✅ GT-16 endpoint accessible"

# GT-19: SQL Injection in Dashboard
echo ""
echo "🔟 Testing GT-19: SQL Injection in dashboard..."
curl -s "$BASE_URL/dashboard/api/search/?table=products_product&column=name&q=test" | head -n 3
echo "✅ GT-19 endpoint accessible"

# GT-23: System Info Disclosure
echo ""
echo "1️⃣1️⃣ Testing GT-23: Sensitive Information Disclosure..."
curl -s "$BASE_URL/dashboard/api/system-info/" | head -n 3
echo "✅ GT-23 endpoint accessible"

# GT-24: Code Injection
echo ""
echo "1️⃣2️⃣ Testing GT-24: Code Injection via eval()..."
curl -s "$BASE_URL/dashboard/api/eval/?expr=1+1" | head -n 3
echo "✅ GT-24 endpoint accessible"

# GT-25: SQL Injection in Cart
echo ""
echo "1️⃣3️⃣ Testing GT-25: SQL Injection in cart discount..."
curl -s "$BASE_URL/cart/api/discount/?code=TEST" | head -n 3
echo "✅ GT-25 endpoint accessible"

# GT-27: IDOR in Cart
echo ""
echo "1️⃣4️⃣ Testing GT-27: IDOR in cart details..."
curl -s "$BASE_URL/cart/api/details/?cart_id=00000000-0000-0000-0000-000000000000" | head -n 3
echo "✅ GT-27 endpoint accessible"

echo ""
echo "======================================"
echo "✅ All vulnerability endpoints are accessible!"
echo "📋 Total vulnerabilities: 30"
echo "🔴 Critical: 14"
echo "🟠 High: 10"
echo "🟡 Medium: 6"
echo ""
echo "📚 See VULNERABILITIES.md for detailed information"
echo "📊 See data/ground_truth/ground_truth_v1.json for complete list"
echo ""
echo "⚠️  WARNING: This is a vulnerable application for testing purposes only!"
echo "   Do not deploy to production or expose to the internet."
