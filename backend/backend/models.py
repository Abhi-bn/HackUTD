from django.db import models


class Profession(models.Model):
    profession_name = models.CharField(max_length=20)
