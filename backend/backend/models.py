from django.db import models
from django.contrib.auth.models import User


class Profession(models.Model):

    profession_name = models.CharField(max_length=20)


class UserInfo(models.Model):

    userid = models.OneToOneField(User, on_delete=models.CASCADE)

    professionid = models.ForeignKey("Profession", on_delete=models.CASCADE)

    wantstohelp = models.BooleanField(null=False, blank=False, unique=True)


class Emergency(models.Model):

    description = models.CharField(null=False, blank=False, max_length=80)

    datetime = models.DateTimeField(null=False, blank=False, auto_now=True)

    location = models.CharField(max_length=30)
