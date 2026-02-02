"""
Orders URLs - SECURE VERSION
"""
from django.urls import path
from . import views

app_name = 'orders'

urlpatterns = [
    path('checkout/', views.checkout_view, name='checkout'),
    path('place/', views.place_order, name='place'),
    path('', views.order_list, name='list'),
    path('<uuid:order_id>/', views.order_detail, name='detail'),
    path('<uuid:order_id>/cancel/', views.cancel_order, name='cancel'),
    path('coupon/apply/', views.apply_coupon, name='apply_coupon'),
    path('coupon/remove/', views.remove_coupon, name='remove_coupon'),
    
    # VULNERABLE API ENDPOINTS - FOR SECURITY TESTING ONLY
    path('api/search/', views.order_search, name='api_order_search'),  # GT-13
    path('api/import/xml/', views.import_orders_xml, name='api_import_xml'),  # GT-14
    path('api/import/yaml/', views.import_orders_yaml, name='api_import_yaml'),  # GT-15
    path('api/invoice/<uuid:order_id>/', views.order_invoice, name='api_invoice'),  # GT-16
    path('api/update-status/', views.update_order_status, name='api_update_status'),  # GT-17
    path('api/export/', views.export_orders, name='api_export'),  # GT-18
]
