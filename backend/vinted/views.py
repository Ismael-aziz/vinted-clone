# backend/accounts/views.py

from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json

@csrf_exempt
def login(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        email = data.get('email')
        password = data.get('password')

        # Votre logique d'authentification ici, par exemple :
        if email == 'test@example.com' and password == 'password':
            return JsonResponse({'success': True})
        else:
            return JsonResponse({'success': False})
