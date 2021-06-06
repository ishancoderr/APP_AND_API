from django.shortcuts import render

# Create your views here.
from napi import models
from rest_framework import generics

from .serializers import Phonebookserializer

class ListPhonebook(generics.ListCreateAPIView):
    queryset = models.Phonebook.objects.all()
    serializer_class = Phonebookserializer

class DetailPhonebook(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Phonebook.objects.all()
    serializer_class = Phonebookserializer

