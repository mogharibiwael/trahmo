from django.contrib import admin
from .models import *

# Register your models here.

admin.site.register(User)
admin.site.register(Category)
admin.site.register(State)
admin.site.register(Beneficiary)
admin.site.register(Tabraa)
admin.site.register(Benefactor)

