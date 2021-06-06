from django.db import models

# Create your models here.
class Phonebook(models.Model):
    names=models.CharField(max_length=200)
    telNo=models.IntegerField()

    def __str__(self):
        return self.names


