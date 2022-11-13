from rest_framework import serializers
from .models import UserData


class UserInfoSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserData
        fields = ("userName", "wantstohelp", "password",
                  "is_active", "profession", "address", "email", "tokenid")
