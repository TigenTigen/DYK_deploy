#!/usr/bin/env bash

cd /var/www/html/django_project
. venv/bin/activate
echo '\e[92m Проверка обновлений списка необходимых модулей:'
pip install -r https://raw.githubusercontent.com/TigenTigen/do_you_know/apache/requirements

cd /var/www/html/django_project/do_you_know
echo '\e[92m Проверка обновлений в удаленном репозитории:'
git pull --strategy-option=theirs

cd /var/www/html/django_project/do_you_know/django
echo '\e[92m Сборка статических файлов:'
python manage.py collectstatic --no-input
echo '\e[92m Создание миграций:'
python manage.py makemigrations user core img contacts
echo '\e[92m Применение миграций:'
python manage.py migrate

echo '\e[92m Запуск сервера  apache2:'
apache2ctl -D FOREGROUND
