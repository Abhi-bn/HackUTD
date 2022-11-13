from rest_framework import serializers
from django.contrib.auth.models import User


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ('id', 'is_active', 'username')


class UserSerializerFull(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = "__all__"
