# Generated by Django 4.1.3 on 2022-11-13 00:12

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('backend', '0004_user'),
    ]

    operations = [
        migrations.CreateModel(
            name='Emergency',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('description', models.CharField(max_length=80)),
                ('datetime', models.DateTimeField(auto_now=True)),
                ('location', models.CharField(max_length=30)),
            ],
        ),
        migrations.CreateModel(
            name='UserInfo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('wantstohelp', models.BooleanField(unique=True)),
                ('professionid', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='backend.profession')),
                ('userid', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.DeleteModel(
            name='User',
        ),
    ]
