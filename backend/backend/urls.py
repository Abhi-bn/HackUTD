"""backend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from backend.views import loginValidator, hello_world
from django.urls import re_path
from backend.views import UserViewSet

urlpatterns = [
    re_path(r'^user$', UserViewSet.as_view(
        {
            'get': 'retrieve',
            'post': 'create',
            'put': 'update',
            'patch': 'partial_update',
            'delete': 'destroy'
        }
    )),
    re_path(r'^user/all$', UserViewSet.as_view(
        {
            'get': 'list',
        }
    )),
    path('admin/', admin.site.urls),
    path('home', hello_world),
    path('login', loginValidator),
    re_path(r'^abc$', UserViewSet.as_view(
        {
            'get': 'retrieve',
            'post': 'create',
            'put': 'update',
            'patch': 'partial_update',
            'delete': 'destroy'
        }
    )),
    re_path(r'^user/all$', UserViewSet.as_view(
        {
            'get': 'list',
        }
    )),
]
