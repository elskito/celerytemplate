## Backend
Rename <b>.env.example</b> to <b>.env</b> 
```
$ docker compose -f docker-compose.yml up
```
Next open the django shell using:

```
$ docker exec -it flower_behind_django-backend-1 python manage.py shell
```
To run task:

```
$ from backend.celery import tester
$ tester.delay()
```
Go to <b>localhost:1337/flower</b> to see flower dashboard

Open a Network tab to observe requests

Try to terminate a task


