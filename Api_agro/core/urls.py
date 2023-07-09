from django.contrib import admin
from django.urls import path, include
from rest_framework import routers
from agro.views import *


router = routers.DefaultRouter()
router.register('user', UserViewSets , basename= 'user')
router.register('animal', AnimalViewSets , basename= 'animal')
router.register('vacina', VacinaViewSets , basename= 'vacina')
router.register('lembrete', LembreteViewSets , basename= 'lembrete')
router.register('doencas', DoencasViewSets , basename= 'doencas')
router.register('parasita', ParasitaViewSets , basename= 'parasita')


urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls))
]


