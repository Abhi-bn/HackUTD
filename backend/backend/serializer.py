from rest_framework import serializers
from .models import UserData
from .models import Emergency


class UserInfoSerializer(serializers.ModelSerializer):

    class Meta:
        model = UserData
        fields = ("userName", "wantstohelp", "password",
                  "is_active", "profession", "address", "email", "tokenid","id")


class EmergencySerializerFull(serializers.ModelSerializer):
    class Meta:
        model = Emergency
        fields = '__all__'
