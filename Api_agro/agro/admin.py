from django.contrib import admin
from agro.models import *

# Register your models here.
class user (admin.ModelAdmin):
    list_display = ('nome', 'cpf', 'numero','email','senha')
    search_fields = ('nome',)

admin.site.register(User, user)


class animal (admin.ModelAdmin):
    list_display = ('categoria','nome','idade','raca','peso')
    search_fields = ('nome',)

admin.site.register(Animal, animal)