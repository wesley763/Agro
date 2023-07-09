from django.shortcuts import render
from agro.models import *
from agro.serializer import AnimalSerializer, UserSerializer, VacinaSerializer,ParasitaSerializer,DoencasSerializer,LembreteSerializer
from rest_framework import viewsets
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Animal


# Create your views here.


class UserViewSets(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    
class AnimalViewSets(viewsets.ModelViewSet):
    queryset = Animal.objects.all()
    serializer_class = AnimalSerializer


class VacinaViewSets(viewsets.ModelViewSet):
    queryset = Vacina.objects.all()
    serializer_class = VacinaSerializer
    
class ParasitaViewSets(viewsets.ModelViewSet):
    queryset = Parasita.objects.all()
    serializer_class = ParasitaSerializer
    
class DoencasViewSets(viewsets.ModelViewSet):
    queryset = Doencas.objects.all()
    serializer_class = DoencasSerializer
    
class LembreteViewSets(viewsets.ModelViewSet):
    queryset = Lembrete.objects.all()
    serializer_class = LembreteSerializer

    