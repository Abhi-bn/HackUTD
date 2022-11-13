from django.shortcuts import render, get_object_or_404
from .serializer import UserSerializer, UserSerializerFull
from django.contrib.auth.models import User
from rest_framework.viewsets import ModelViewSet
from django.http import JsonResponse
from rest_framework.decorators import api_view
import json
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.http import HttpResponse


def hello_world(request):
    return JsonResponse({"hello": "helloWorld"})


@api_view(['POST'])
def loginValidator(request):
    loginValidatorResult = {}
    body_unicode = request.body.decode('utf-8')
    body = json.loads(body_unicode)
    email = body['email']
    password = body['password']

    check_if_user_exists = User.objects.filter(
        email=email).exists()

    if check_if_user_exists:
        user = User.objects.filter(email=email)
        # serializer = UserSerializerFull(user)
        userName = (user[0])
        user = authenticate(
            request, username=userName, password=password)

        if user is not None:

            return JsonResponse({'isValid': True, 'errorResponse': "None"})
            # # loginValidatorResult["userName"] = userName
            # loginValidatorResult["errorStatus"] = None
            # loginValidatorResult["isValidUser"] = True

            return HttpResponse("Sucessful")
            # return JsonResponse(json.dumps(loginValidatorResult))
        else:
            return JsonResponse({'isValid': False, 'errorResponse': "User Exists, password mismatch"})

    else:
        return JsonResponse({'isValid': False, 'errorResponse': "User Does Not Exist"})


class UserViewSet(ModelViewSet):
    serializer_class = UserSerializer

    def retrieve(self, request, *args, **kwargs):
        return JsonResponse({'data': self.get_serializer(self.get_object()).data})

    def get_object(self):
        return get_object_or_404(User, id=self.request.query_params.get("id"))

    def get_queryset(self):
        return User.objects.filter(is_active=True).order_by('-username')

    def perform_destroy(self, instance):
        instance.is_active = False
        instance.save()
