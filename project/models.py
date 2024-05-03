from django.db import models
from django.contrib.auth.models import AbstractUser, BaseUserManager

# Create your models here.

class UserManager(BaseUserManager):
    use_in_migrations = True

class User(AbstractUser):
  email=models.EmailField(unique=True)

  def __str__(self):
        return self.username
 
   

class Category(models.Model):
    name=models.CharField(max_length=180)
    image=models.ImageField(upload_to='static/category')
    description=models.TextField()
    def __str__(self):
        return self.name




class Beneficiary(models.Model):
    name=models.CharField(max_length=180)
    address=models.CharField(max_length=180)
    phone=models.CharField(max_length=15)
    note=models.TextField()

    def __str__(self):
        return self.name

class State(models.Model):
    name=models.CharField(max_length=180)
    amount=models.DecimalField(max_digits=20, decimal_places=2)
    image=models.ImageField(upload_to='static/state')
    description=models.TextField()
    address=models.CharField(max_length=180)
    benficiary=models.ForeignKey(Beneficiary,related_name='state_beneficiary',on_delete=models.CASCADE)
    category=models.ForeignKey(Category,related_name='state_category',on_delete=models.RESTRICT)
    is_from_app=models.BooleanField(default=False)
    is_active=models.BooleanField(default=True)
    
    def __str__(self):
        return self.name



class Benefactor(models.Model):
        name=models.CharField(max_length=180)
        amount=models.DecimalField(max_digits=8, decimal_places=2)
        phone=models.CharField(max_length=15)
        aother_benefactor=models.CharField(max_length=180)
        aother_phone=models.CharField(max_length=15)


class Tabraa(models.Model):
    paid=models.DecimalField(max_digits=8, decimal_places=2)
    category=models.ForeignKey(Category,related_name='tabraa_category',on_delete=models.CASCADE)
    benficiary=models.ForeignKey(Beneficiary,related_name='tabraa_benficiary',on_delete=models.CASCADE)
    state=models.ForeignKey(State,related_name='tabraa_state',on_delete=models.CASCADE)
    is_done=models.BooleanField(default=False)
    completed_date=models.DateField(null=True)
    benefactor=models.ManyToManyField(Benefactor,null=True)





