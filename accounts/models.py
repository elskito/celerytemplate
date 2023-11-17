from django.contrib.auth.models import AbstractUser


class CustomUser(AbstractUser):
    """CustomUser definition."""

    def __str__(self):
        return self.username
