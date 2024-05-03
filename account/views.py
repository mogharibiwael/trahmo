from django.shortcuts import render
from django.contrib.auth.forms import AuthenticationForm

# Create your views here.

def login(request):
    print("yesss")
    form = AuthenticationForm()
    return render(request, 'login.html', {'form': form})


