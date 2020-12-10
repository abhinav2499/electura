from rest_framework import serializers
from rest_framework.serializers import FileField, Serializer, CharField
from rest_framework.permissions import IsAuthenticated
from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.contrib.auth.hashers import make_password
from .models import File


class RegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'password')
        extra_kwargs = {
            'password': {'write_only': True},
        }

    def create(self, validated_data):
        user = User.objects.create_user(
            validated_data['username'], password=validated_data['password'], email=validated_data['email'])
        return user


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'password']


class UploadSerializer(serializers.ModelSerializer):
    file_uploaded = FileField()

    class Meta:
        model = File
        fields = ['title', 'file_uploaded']
