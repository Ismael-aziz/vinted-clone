# backend/urls.py

from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('vinted.urls')),  # Ajoutez cette ligne pour inclure les URLs de votre application accounts
]
