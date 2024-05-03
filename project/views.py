from decimal import Decimal
from django.shortcuts import get_object_or_404, render
from django.contrib.auth.decorators import login_required
from django.shortcuts import render,redirect

from  .form import *
from .models import *
from django.contrib import messages


# Create your views here.

@login_required
def index(request):
    return render(request,'home.html')




# category

@login_required
def category(request):
    return render(request,'categories.html',)


# Create your views here.

def add_category(request):
    if request.method == 'POST':
        form = CategoryForm(request.POST, request.FILES)
        if form.is_valid():
            # Process the form data
            name = form.cleaned_data['name']
            image = form.cleaned_data['image']
            description = form.cleaned_data['description']
            
            
            # Create a new product object with the form data and associated category
            data = Category(
                name=name,
                image=image,
                description=description
            )
            data.save()
            messages.success(request, 'تمت الاضافة بنجاح')
            return redirect('show_category')  # Redirect to a success page
        else:
            messages.error(request, 'لم تتم الاضافة الرجاء التاكد واعادة المحاوله')
    else:
        form = CategoryForm()    

    return render(request, 'add_category.html', {'form': form})


@login_required
def show_category(request):
    categories=Category.objects.all()
    return render(request,'show_categories.html',{'categories':categories})


@login_required
def state(request):
    return render(request,'state.html',)


# state




# Create your views here.

def add_state(request):
    if request.method == 'POST':
        form = StateForm(request.POST, request.FILES)
        if form.is_valid():
            # Process the form data
            name = form.cleaned_data['name']
            image = form.cleaned_data['image']
            description = form.cleaned_data['description']
            category = form.cleaned_data['category']
            benficiary = form.cleaned_data['benficiary']
            address = form.cleaned_data['address']
            amount = form.cleaned_data['amount']
            # benefactor = form.cleaned_data['benefactor']

            
            
            # Create a new product object with the form data and associated category
            data = State(
                name=name,
                image=image,
                description=description,
                amount=amount,
                address=address,
                benficiary=benficiary,
                category=category,
                is_from_app=False,
                is_active=True


            )
            data.save()
            state_id=data
            data2 = Tabraa(
                paid=0,
                state=state_id,
                is_done=False,
                benficiary=benficiary,
                category=category
            )
            data2.save()
            messages.success(request, 'تمت الاضافة بنجاح')
            return redirect('show_state')  # Redirect to a success page
        else:
            messages.error(request, 'لم تتم الاضافة الرجاء التاكد واعادة المحاوله')
    else:
        form = StateForm()    

    return render(request, 'add_state.html', {'form': form})


@login_required
def show_state(request):
    states=State.objects.all()
    return render(request,'show_state.html',{'states':states})



# benficiary

@login_required
def benficiary(request):
    return render(request,'benficiary.html',)


# Create your views here.

def add_benficiary(request):
    if request.method == 'POST':
        form = BeneficiaryForm(request.POST, request.FILES)
        if form.is_valid():
            # Process the form data
            name = form.cleaned_data['name']
            address = form.cleaned_data['address']
            phone = form.cleaned_data['phone']
            note = form.cleaned_data['note']
            # Create a new product object with the form data and associated category
            data = Beneficiary(
                name=name,
                address=address,
                phone=phone,
                note=note
            )
            data.save()
            messages.success(request, 'تمت الاضافة بنجاح')
            return redirect('show_benficiary')  # Redirect to a success page
        else:
            messages.error(request, 'لم تتم الاضافة الرجاء التاكد واعادة المحاوله')
    else:
        form = BeneficiaryForm()    

    return render(request, 'add_benficiary.html', {'form': form})


@login_required
def show_benficiary(request):
    beneficiary=Beneficiary.objects.all()
    return render(request,'show_benficiary.html',{'benficiary':beneficiary})


# tabraa
@login_required
def tabraa(request):
    return render(request,'tabraa.html',)

@login_required
def show_tabraa(request):
    tabrat=Tabraa.objects.order_by('-id')[:5]
    return render(request,'show_tabraa.html',{'tabrat':tabrat})

@login_required
def show_tabraa_page(request):
    tabrat=Tabraa.objects.all()
    return render(request,'tabraat_page.html',{'tabrat':tabrat})


def edit_state(request, id):
    state = get_object_or_404(State, id=id)

    if request.method == 'POST':
        form = StateEditForm(request.POST, instance=state)
        if form.is_valid():
            form.save()
            messages.success(request, 'تم التعديل بنجاح')
            return redirect('show_state') 
        messages.error(request, 'هناك خطأ')
 # Redirect to the product detail page
    else:
        form = StateEditForm(instance=state)

    return render(request, 'edit_state.html', {'form': form})
@login_required
def delete_state(request, id):
    state = get_object_or_404(State, pk=id)
    if request.method == 'GET':
        state.delete()
        messages.success(request, 'تم الحذف بنجاح')
        return redirect('show_state') 
    
@login_required
def get_done_tabraa(request):
    tabrat=Tabraa.objects.filter(is_done=True)
    return render(request,'tabraat_page.html',{'tabrat':tabrat})

@login_required
def get_not_done_tabraa(request):
    tabrat=Tabraa.objects.filter(is_done=False)
    return render(request,'tabraat_page.html',{'tabrat':tabrat})

@login_required
def get_tabraa_details(request,id):
    tabrat=Tabraa.objects.get(id=id)
    return render(request,'tabraa_details.html',{'data':tabrat})

@login_required
def activate_state(request,id):
    try:
        state=State.objects.get(id=id)
        state.is_active=True
        state.save()
        messages.success(request, 'تم التعديل بنجاح')
        return redirect('state_from_app') 

    except:
        messages.error(request, 'هناك خطأ')
        return redirect('state_from_app') 


def state_from_app(request):
    states=State.objects.filter(is_from_app=True,is_active=False)
    return render(request,'state_from_app.html',{'states':states})

@login_required
def state_from_app_details(request,id):
    state=State.objects.get(id=id)
    return render(request,'state_from_app_details.html',{'data':state})

