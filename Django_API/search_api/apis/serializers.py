from rest_framework import serializers
from napi import models

class Phonebookserializer(serializers.ModelSerializer):
    class Meta:
        fields=(
            'id',
            'names',
            'telNo',
        )
        model=models.Phonebook

