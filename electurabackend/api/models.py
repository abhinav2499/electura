from django.db import models
from rest_framework.serializers import FileField
# Create your models here.


class File(models.Model):
    title = models.CharField(unique=True, max_length=80)
    file_uploaded = FileField()
    added = models.DateTimeField(auto_now_add=True)
    owner = models.ForeignKey(
        'auth.User', related_name='uploads', on_delete=models.CASCADE)

    class Meta:
        ordering = ['added']
