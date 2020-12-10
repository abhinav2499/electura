from django.conf.urls import url
from django.urls import path, include
from .registration import RegisterApi
from .views import UploadList, UserList, UserDetail


urlpatterns = [
    path('uploads/', UploadList.as_view()),
    path('register/', RegisterApi.as_view()),
    path('users/', UserList.as_view()),
    path('users/<int:pk>/', UserDetail.as_view()),
]
