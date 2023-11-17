import logging

from django.conf import settings
from django.core.management.base import BaseCommand

from accounts.models import CustomUser

LOGGER = logging.getLogger(__name__)


class NoPasswordError(Exception):
    """Raise when password is equal to empty string."""


class Command(BaseCommand):
    def handle(self, *args, **options):
        if CustomUser.objects.count() == 0:
            password = settings.ADMIN_PASSWORD
            if not password:
                raise NoPasswordError
            LOGGER.info("Creating admin account")
            admin = CustomUser.objects.create_superuser(username="admin", password=password)
            admin.is_active = True
            admin.is_admin = True
            admin.save()
        else:
            LOGGER.info("Admin accounts can only be initialized if no Accounts exist")
