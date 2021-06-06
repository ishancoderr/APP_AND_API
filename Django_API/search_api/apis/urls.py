from django.urls import path
from .views import ListPhonebook, DetailPhonebook

urlpatterns = [
    path('', ListPhonebook.as_view()),
    path('<int:pk>', DetailPhonebook.as_view())
]