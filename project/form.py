# forms.py

from django import forms

from project.models import *

class CategoryForm(forms.Form):
    name = forms.CharField(max_length=100)
    image = forms.ImageField()
    description=forms.CharField(widget=forms.Textarea(attrs={'class': 'my-class'}))

class BeneficiaryForm(forms.Form):
    name = forms.CharField(max_length=100)
    address = forms.CharField()
    phone = forms.CharField()
    note=forms.CharField()

class StateForm(forms.Form):
    name=forms.CharField(max_length=100)
    amount=forms.DecimalField()
    image=forms.ImageField()
    description=forms.CharField(widget=forms.Textarea(attrs={'class': 'my-class'}))
    address=forms.CharField()
    benficiary= forms.ModelChoiceField(queryset=Beneficiary.objects.all())
    category= forms.ModelChoiceField(queryset=Category.objects.all())
    # benefactor = forms.ModelMultipleChoiceField(queryset=Benefactor.objects.all())


class StateEditForm(forms.ModelForm):
    class Meta:
        model = State
        fields = ['name', 'amount', 'image','description','address','benficiary','category']  # Add the fields you want to edit




"""
 name=models.CharField(max_length=180)
    amount=models.DecimalField(max_digits=8, decimal_places=2)
    image=models.ImageField(upload_to='static/state')
    description=models.TextField()
    address=models.CharField(max_length=180)
    user=models.ForeignKey(User,related_name='state_user',on_delete=models.CASCADE)
    category=models.ForeignKey(Category,related_name='state_category',on_delete=models.RESTRICT)

"""

  

