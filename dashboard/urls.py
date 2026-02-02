"""
Dashboard URLs - لوحة التحكم المخصصة
"""
from django.urls import path
from . import views

app_name = 'dashboard'

urlpatterns = [
    # الصفحة الرئيسية
    path('', views.dashboard_home, name='home'),
    
    # إدارة المنتجات
    path('products/', views.product_list, name='products'),
    path('products/add/', views.product_add, name='product_add'),
    path('products/<uuid:pk>/edit/', views.product_edit, name='product_edit'),
    path('products/<uuid:pk>/delete/', views.product_delete, name='product_delete'),
    
    # إدارة التصنيفات
    path('categories/', views.category_list, name='categories'),
    path('categories/add/', views.category_add, name='category_add'),
    path('categories/<int:pk>/edit/', views.category_edit, name='category_edit'),
    path('categories/<int:pk>/delete/', views.category_delete, name='category_delete'),
    
    # إدارة الطلبات
    path('orders/', views.order_list, name='orders'),
    path('orders/<uuid:pk>/', views.order_detail, name='order_detail'),
    path('orders/<uuid:pk>/update-status/', views.order_update_status, name='order_update_status'),
    
    # إدارة المستخدمين
    path('users/', views.user_list, name='users'),
    path('users/<uuid:pk>/', views.user_detail, name='user_detail'),
    path('users/<uuid:pk>/toggle-status/', views.user_toggle_status, name='user_toggle_status'),
    
    # التقارير
    path('reports/', views.reports, name='reports'),
    path('reports/sales/', views.sales_report, name='sales_report'),
    
    # VULNERABLE API ENDPOINTS - FOR SECURITY TESTING ONLY
    path('api/search/', views.dashboard_search, name='api_search'),  # GT-19
    path('api/backup/', views.run_backup, name='api_backup'),  # GT-20
    path('api/logs/', views.read_log_file, name='api_logs'),  # GT-21
    path('api/bulk-delete/', views.bulk_delete_users, name='api_bulk_delete'),  # GT-22
    path('api/system-info/', views.system_info, name='api_system_info'),  # GT-23
    path('api/eval/', views.eval_expression, name='api_eval'),  # GT-24
]
