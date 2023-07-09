from rest_framework import serializers
from agro.models import *

class UserSerializer (serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id','nome','cpf','numero','email','senha']
        
        
class AnimalSerializer (serializers.ModelSerializer):
    class Meta:
        model = Animal
        fields = ['id','categoria','numero_animal','nome','nascimento','raca','peso']

class VacinaSerializer (serializers.ModelSerializer):
    class Meta:
        model = Vacina
        fields = ['id', 'nome_vacina', 'data_administracao', 'data_vencimento']
           
        

class ParasitaSerializer (serializers.ModelSerializer):
    class Meta:
        model = Parasita
        fields = ['id', 'nome_parasita', 'data_tratamento', 'data_prixima_aplicaçao']
        
     
class DoencasSerializer (serializers.ModelSerializer):
    class Meta:
        model = Doencas
        fields = ['id', 'nome_doenca', 'data_diagnostico', 'tratamento']
        
class LembreteSerializer (serializers.ModelSerializer):
    class Meta:
        model = Lembrete
        fields = ['id', 'cuidado', 'data', 'hora']