from django.shortcuts import render, get_object_or_404
from .serializer import UserInfoSerializer, EmergencySerializerFull
from backend.models import Emergency
from rest_framework.viewsets import ModelViewSet
from django.http import JsonResponse
from rest_framework.decorators import api_view
import json
# from django.contrib.auth.models import User
from backend.models import UserData
from django.contrib.auth import authenticate
from django.http import HttpResponse


def hello_world(request):
    return JsonResponse({"hello": "helloWorld"})


@api_view(['POST'])
def loginValidator(request):
    body_unicode = request.body.decode('utf-8')
    body = json.loads(body_unicode)
    email = body['email']
    password = body['password']

    check_if_user_exists = UserData.objects.filter(
        email=email).exists()

    if check_if_user_exists:
        user = UserData.objects.filter(email=email)
        userName = (user[0])
        user = authenticate(
            request, username=userName, password=password)

        if user is not None:
            user = User.objects.filter(email=email).get().values(
                'id', 'is_active', 'username')
            return JsonResponse({'data': UserInfoSerializer(user, many=True).data, 'isValid': True, 'errorResponse': "None"})
        else:
            return JsonResponse({'isValid': False, 'errorResponse': "User Exists, password mismatch"})
    else:
        return JsonResponse({'isValid': False, 'errorResponse': "User Does Not Exist"})


class UserViewSet(ModelViewSet):
    serializer_class = UserInfoSerializer

    def retrieve(self, request, *args, **kwargs):
        return JsonResponse({'data': self.get_serializer(self.get_object()).data})

    def get_object(self):
        return get_object_or_404(UserData, id=self.request.query_params.get("id"))

    def get_queryset(self):
        return UserData.objects.filter(is_active=True).order_by('-username')

    def perform_destroy(self, instance):
        instance.is_active = False
        instance.save()


class EmergencyViewSet(ModelViewSet):
    serializer_class = EmergencySerializerFull

    def retrieve(self, request, *args, **kwargs):
        return JsonResponse(self.get_serializer(self.get_object()).data)

    def get_object(self):
        return get_object_or_404(Emergency, id=self.request.query_params.get("id"))

    def get_queryset(self):
        return Emergency.objects.all()

    def perform_destroy(self, instance):
        instance.is_active = False
        instance.save()

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())
        return JsonResponse({'data': self.get_serializer(queryset, many=True).data})

    def update(self, request, *args, **kwargs):
        return super().update(request, *args, **kwargs)

    def login(self, request):
        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)
        email = body['email']
        password = body['password']

        check_if_user_exists = UserData.objects.filter(
            email=email).exists()

        if check_if_user_exists:
            user = UserData.objects.filter(email=email)
            userData = UserInfoSerializer(user, many=True).data
            userData = userData[0]
            if userData["password"] == password:
                userData["isValid"] = True
                userData["errorResponse"] = None
                return JsonResponse(userData)

            else:
                return JsonResponse({'isValid': False, 'errorResponse': "User Exists, password mismatch"})

        else:
            return JsonResponse({'isValid': False, 'errorResponse': "User Does Not Exist"})
