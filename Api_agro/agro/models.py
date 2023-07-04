from django.db import models

# Create your models here.
class User (models.Model):
    nome = models.CharField(max_length = 255)
    cpf = models.CharField(max_length = 255)
    numero = models.CharField(max_length = 255)
    email = models.CharField(max_length = 255)
    senha = models.CharField(max_length = 255)

    def __str__(self):
        return self.nome

class Animal (models.Model):
    nome = models.CharField(max_length = 255)
    categoria = models.CharField(max_length = 255)
    idade = models.CharField(max_length = 255)
    raca = models.CharField(max_length = 255)
    peso = models.CharField(max_length = 255)

    def __str__(self):
            return self.nome