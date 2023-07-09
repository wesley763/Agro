from django.db import models

# Create your models here.
class User (models.Model):
    id = models.AutoField(primary_key=True)
    
    nome = models.CharField(max_length = 255)
    cpf = models.CharField(max_length = 255,  unique= True)
    numero = models.CharField(max_length = 255)
    email = models.CharField(max_length = 255, unique= True)
    senha = models.CharField(max_length = 255)

    def __str__(self):
        return self.nome

class Animal (models.Model):
    nome = models.CharField(max_length = 255)
    numero_animal = models.CharField(max_length= 10,unique= True)
    categoria = models.CharField(max_length = 255)
    idade = models.CharField(max_length = 255)
    raca = models.CharField(max_length = 255)
    peso = models.CharField(max_length = 255)

    def __str__(self):
            return self.nome