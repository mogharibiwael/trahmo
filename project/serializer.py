from rest_framework import serializers
from .models import *


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields ='__all__'

class BenefactorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Benefactor
        fields = '__all__'

class StateSerializer(serializers.ModelSerializer):
    class Meta:
        model = State
        fields ='__all__'

class TabraaSerializer(serializers.ModelSerializer):
    state=StateSerializer(many=False)
    paid=serializers.SerializerMethodField()
    category_name=serializers.ReadOnlyField(source='category.name')
    benefactor = BenefactorSerializer(many=True)  # Serializer for the benefactor field

    class Meta:
        model = Tabraa
        fields ='__all__'

    def get_paid(self, obj):
        return obj.state.amount - obj.paid


