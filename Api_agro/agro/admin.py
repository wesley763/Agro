from django.contrib import admin
from agro.models import *

# Register your models here.
class user (admin.ModelAdmin):
    list_display = ('id','nome', 'cpf', 'numero','email','senha')
    search_fields = ('id',)

admin.site.register(User, user)


class animal (admin.ModelAdmin):
    list_display = ('id','categoria','numero_animal','nome','nascimento','raca','peso')
    search_fields = ('id',)

admin.site.register(Animal, animal)



class vacina (admin.ModelAdmin):
    list_display = ('id', 'nome_vacina', 'data_administracao', 'data_vencimento')
    search_fields = ('id',)

admin.site.register(Vacina, vacina)

class parasita (admin.ModelAdmin):
    list_display = ('id', 'nome_parasita', 'data_tratamento', 'data_prixima_aplicaçao')
    search_fields = ('id',)

admin.site.register(Parasita, parasita)

class doencas (admin.ModelAdmin):
    list_display = ('id', 'nome_doenca', 'data_diagnostico', 'tratamento')
    search_fields = ('id',)

admin.site.register(Doencas, doencas)

class lembrete (admin.ModelAdmin):
    list_display = ('id', 'cuidado', 'data', 'hora')
    search_fields = ('id',)

admin.site.register(Lembrete, lembrete)