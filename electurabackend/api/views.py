from rest_framework import viewsets
from rest_framework.response import Response
from .serializers import UploadSerializer, UserSerializer
from rest_framework import generics, permissions
from .models import File
from django.contrib.auth.models import User
from rest_framework.parsers import FileUploadParser


class UserList(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class UserDetail(generics.RetrieveAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class UploadViewSet(viewsets.ModelViewSet):

    queryset = File.objects.all()
    serializer_class = UploadSerializer
