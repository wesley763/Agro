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
        return self.id

class Animal (models.Model):
    id = models.AutoField(primary_key=True)
    nome = models.CharField(max_length = 255)
    numero_animal = models.CharField(max_length= 10,unique= True)
    categoria = models.CharField(max_length = 255)
    nascimento = models.DateField()
    raca = models.CharField(max_length = 255)
    peso = models.CharField(max_length = 255)

    def __str__(self):
            return self.id
        
class Vacina (models.Model):
    id = models.AutoField(primary_key=True)
    nome_vacina = models.CharField(max_length = 255)
    data_administracao = models.DateField()
    data_vencimento = models.DateField()
    
    def __str__(self):
        return self.id
    
class Parasita (models.Model):
    id = models.AutoField(primary_key=True)
    nome_parasita = models.CharField(max_length = 255)
    data_tratamento = models.DateField()
    data_prixima_aplicaçao = models.DateField()
    
    def __str__(self):
        return self.id
    
class Doencas (models.Model):
    id = models.AutoField(primary_key=True)
    nome_doenca= models.CharField(max_length = 255)
    data_diagnostico = models.DateField()
    tratamento= models.CharField(max_length = 255)
    
    def __str__(self):
        return self.id
    
    
class Lembrete (models.Model):
    id = models.AutoField(primary_key=True)
    cuidado= models.CharField(max_length = 255)
    data = models.DateField()
    hora = models.TimeField()
    
    def __str__(self):
        return self.id