from decimal import Decimal
import json
import os
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.shortcuts import render,redirect
from rest_framework.response import Response
from rest_framework import status
from django.db import transaction
from django.db.models import F
from tempfile import TemporaryFile





from rest_framework.decorators import api_view

from project.serializer import *


from  .form import *
from .models import *
# from django.contrib import messages


# Create your views here.

@api_view(['POST','GET'])
def get_category(request):
    if request.method == 'GET':
        category = Category.objects.all()
        serializer = CategorySerializer(category, many=True).data
        return Response(serializer,status=status.HTTP_200_OK)
    
@api_view(['POST','GET'])
def get_state(request):
    try:
        if request.method == 'GET':
            print("sdidiid")
            state = Tabraa.objects.select_related('state').filter(state__amount__gt=F('paid'),state__is_active=True)
            serializer = TabraaSerializer(state, many=True).data
            return Response(serializer,status=status.HTTP_200_OK)
    except Exception as e:
        return Response(str(e),status=status.HTTP_501_NOT_IMPLEMENTED)
    
    
@api_view(['POST','GET'])
def get_state_details(request,id):
    if request.method == 'GET':
        tabraa = Tabraa.objects.filter(state=id)
        serializer = TabraaSerializer(tabraa, many=True).data
        return Response(serializer,status=status.HTTP_200_OK)
    
@api_view(['POST','GET'])
def send_tabraa(request):
   try: 
    if request.method == 'POST':
            mutable_data = request.POST.copy()
            
            try:
                tabraa = Tabraa.objects.get(id=int(mutable_data['id']))
            except Tabraa.DoesNotExist:
                return Response("Invalid tabraa ID", status=status.HTTP_404_NOT_FOUND)
            
            amount = Decimal(mutable_data['amount'])
            
            data_load=json.loads(mutable_data['benefactor'])
            print(data_load)
            print(data_load['name'])
            benefactor= Benefactor.objects.create(
                name=data_load['name'],
                amount=Decimal(data_load['amount']),
                phone=data_load['phone'],
                aother_benefactor=data_load['aother_benefactor'],
                aother_phone=data_load['aother_phone'],
            )
            tabraa.paid = tabraa.paid + Decimal(data_load['amount'])
            if tabraa.paid >= tabraa.state.amount:
                tabraa.is_done=True
            tabraa.save()
            print(benefactor)
            tabraa.benefactor.add(benefactor)
            serializer=TabraaSerializer(tabraa).data
            return Response(serializer, status=status.HTTP_200_OK)
            

    return Response(status=status.HTTP_501_NOT_IMPLEMENTED)
           

   except Exception as e:
    print(e,'---------')
    return Response(str(e),status=status.HTTP_501_NOT_IMPLEMENTED)
   

@api_view(['POST','GET'])
def get_category_with_product(request):
    if request.method == 'GET':
        category = Category.objects.all()
        serializer = CategorySerializer(category, many=True).data
        return Response(serializer,status=status.HTTP_200_OK)
    from rest_framework.decorators import api_view
from rest_framework.response import Response

@api_view(['GET'])
def get_category_with_state(request):
    if request.method == 'GET':
       try: 
        categories = Category.objects.all()
        serialized_data = []
        for category in categories:
            data = {
                'id': category.id,
                'name': category.name,
                'image': category.image.url,
                'description': category.description,
                'states': []
            }
            
            states = State.objects.filter(category=category,is_active=True)
            for state in states:
                state_data = {
                    'id': state.id,
                    'name': state.name,
                    'amount': str(state.amount),
                    'image': state.image.url,
                    'description': state.description,
                    'address': state.address,
                    'beneficiary': state.benficiary.id
                }
                data['states'].append(state_data)
                
            
            serialized_data.append(data)

       except Exception as e:
        return Response(str(e))

    return Response(serialized_data, status=status.HTTP_200_OK)

@api_view(['POST','GET'])
def get_state_by_category(request,id):
    print("****************************")
    try:
        if request.method == 'GET':
            print("sdidiid")
            state = Tabraa.objects.select_related('state').filter(category=id)
            serializer = TabraaSerializer(state, many=True).data
            print(serializer)
            return Response(serializer,status=status.HTTP_200_OK)
    except Exception as e:
        return Response(str(e),status=status.HTTP_501_NOT_IMPLEMENTED)
    
def handle_uploaded_image(file):
    try:
        if file is not None:
            # Generate a unique filename for the image
            filename = str(file.name)
            file_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'static', 'images', filename)
                        
            with open(file_path, 'wb') as destination:
                for chunk in file.chunks():
                    destination.write(chunk)

            return filename
        else:
            raise ValueError("No file uploaded")
    except Exception as e:
        print(str(e))
        return None

@api_view(['POST'])
def add_state_from_app(request):
    try: 
        if request.method == 'POST':
            file = request.FILES.get('image')

            if file:
                # Save the image in the static/images directory
                filename = handle_uploaded_image(file)
                if filename:
                    # Accessing other form data
                    name = request.POST.get('name')
                    amount = request.POST.get('amount')
                    description = request.POST.get('description')
                    address = request.POST.get('address')
                    beneficiary_name = request.POST.get('benficiary[name]')
                    beneficiary_address = request.POST.get('benficiary[address]')
                    beneficiary_phone = request.POST.get('benficiary[phone]')
                    beneficiary_note = request.POST.get('benficiary[note]')
                    category = request.POST.get('category')
                    print(beneficiary_name,',',beneficiary_address,',',beneficiary_phone,',',beneficiary_note,',',category)
                    
                    category=Category.objects.filter(name=category).first()

                    beneficiary=Beneficiary.objects.create(
                     name= beneficiary_name,
                     address=beneficiary_address,
                     phone=beneficiary_phone,
                     note=beneficiary_note
                    )
                    beneficiary.save()
                    print(beneficiary,'------')
                    state_data= State.objects.create(
                         name=name,
                         amount=amount,
                         image=filename,
                         description=description,
                         address=address,
                         benficiary=beneficiary,
                         category=category,
                         is_from_app=True,
                         is_active=False
                        )
                    state_data.save()
                    state_id=state_data
                    data2 = Tabraa(
                        paid=0,
                        state=state_id,
                        is_done=False,
                        benficiary=beneficiary,
                        category=category
                    )
                    data2.save()
                    print(state_data,'-------------')

                    # Perform desired operations with the received data

                    # Return a JSON response indicating success
                    return Response({'message': 'State added successfully'})
                else:
                    # Return a JSON response indicating failure
                    return Response({'message': 'Failed to save the image'})
            else:
                # Handle the case when no image is uploaded
                return Response({'message': 'No image uploaded'})

    except Exception as e:
        print(str(e))

    return Response(status=status.HTTP_501_NOT_IMPLEMENTED)

