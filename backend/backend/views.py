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
    user = User.objects.filter(email=email)
    userName = (user[0])
    print(userName)
    if check_if_user_exists:
        user = authenticate(
            request, username=userName, password=password)

        if user is not None:
            # loginValidatorResult["userName"] = userName
            loginValidatorResult["errorStatus"] = None
            loginValidatorResult["isValidUser"] = True
            print(loginValidatorResult)
            return HttpResponse("Sucessful")
            # return JsonResponse(json.dumps(loginValidatorResult))
        else:
            # loginValidatorResult["userName"] = None
            loginValidatorResult["isValidUser"] = False
            loginValidatorResult["errorStatus"] = "User Exists, password mismatch"
            # return JsonResponse(json.dumps(loginValidatorResult))
            return HttpResponse("Not sucessful")

    else:
        # there is no such entry with this username in the table
        # loginValidatorResult["userName"] = None
        loginValidatorResult["isValidUser"] = False
        loginValidatorResult["errorStatus"] = "User Exists, password mismatch"
        return HttpResponse("Not Sucessful")
        # return JsonResponse(json.dumps(loginValidatorResult))
