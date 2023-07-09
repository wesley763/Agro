from rest_framework import serializers
from agro.models import *

class UserSerializer (serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id','nome','cpf','numero','email','senha']
        
        
        

class AnimalSerializer (serializers.ModelSerializer):
    class Meta:
        model = Animal
        fields = ['categoria','numero_animal','nome','idade','raca','peso']
        
