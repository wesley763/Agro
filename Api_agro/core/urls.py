from django.contrib import admin
from django.urls import path, include
from rest_framework import routers
from agro.views import *


router = routers.DefaultRouter()
router.register('user', UserViewSets , basename= 'user')
router.register('animal', AnimalViewSets , basename= 'animal')

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(router.urls))
]
