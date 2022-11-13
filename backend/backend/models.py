from django.db import models
from django.contrib.auth.models import User


class Profession(models.Model):
    profession_name = models.CharField(max_length=20)

    class Meta:
        unique_together = ('id', 'profession_name',)


class UserData(models.Model):
    userName = models.CharField(max_length=125, null=False)
    # professionid = models.ForeignKey(Profession, on_delete=models.CASCADE)
    profession = models.IntegerField(null=True)
    wantstohelp = models.BooleanField(null=False, blank=False)
    password = models.CharField(max_length=15, null=False)
    is_active = models.BooleanField(null=False, default=True)
    address = models.CharField(
        max_length=30, null=False, default=True)
    email = models.CharField(max_length=25, null=False,
                             default="hari.deepak1@gmail.com")
    tokenid = models.CharField(max_length=25, null=True)


Emergency_TYPE = (
    (0, 'Normal'),
    (1, 'Animal_Spotting'),
    (2, 'Health_EMERGENCY'),
    (3, 'Theft'),
    (4, 'Other'),
)


class Emergency(models.Model):
    description = models.CharField(null=False, blank=False, max_length=80)
    datetime = models.DateTimeField(null=False, blank=False, auto_now=True)
    location = models.CharField(max_length=30)
    emergency_type = models.IntegerField(choices=Emergency_TYPE)
