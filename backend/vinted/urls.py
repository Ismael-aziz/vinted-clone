# backend/accounts/urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.login, name='login'),
    # Ajoutez d'autres URLs selon vos besoins
]
