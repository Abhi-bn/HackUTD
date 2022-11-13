from django.db import models
from django.contrib.auth.models import User


class Profession(models.Model):
    profession_name = models.CharField(max_length=20)

    class Meta:
        unique_together = ('id', 'profession_name',)


class UserInfo(models.Model):
    userid = models.OneToOneField(User, on_delete=models.CASCADE)
    professionid = models.ForeignKey(Profession, on_delete=models.CASCADE)
    wantstohelp = models.BooleanField(null=False, blank=False, unique=True)


Emergency_TYPE = (
    (0, 'Normal'),
    (1, 'Animal_Spotting'),
    (2, 'Health_EMERGENCY'),
    (3, 'Theft'),
    (4, 'Other'),
)


class Emergency(models.Model):
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    description = models.CharField(null=False, blank=False, max_length=80)
    datetime = models.DateTimeField(null=False, blank=False, auto_now=True)
    location = models.CharField(max_length=30)
    emergency_type = models.CharField(max_length=1, choices=Emergency_TYPE)
