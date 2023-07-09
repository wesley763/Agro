from django.shortcuts import render
from agro.models import *
from agro.serializer import UserSerializer, AnimalSerializer
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
    
