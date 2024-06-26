Автоматизированное создание инфраструктуры для развертывания проекта.

## Автоматическое развертывание инфраструктуры

- Вводим команду

  ```bash
  make
  ```

 - Terraform автоматически разворачивает 2 виртуальные машины
 - Создается s3 backend для хранения terraform state
 - Запускается python-скрипт, который создает файл inventiry.ini для Ansible
 - Происходит установка ПО и автоматизированная настройка виртуальных машин с помощью Ansible

## CI/CD

 - На build-agent клонируется репозиторий
 - Собирается docker-image
 - Docker-image загружается в хранилище dockerhub
 - Происходит запуск контейнера с Web-приложением
 - Результаты пайплайна приходят уведомлением в telegram
 - При коммите происходит сборка исходного кода, загрузка артефакта в хранилище и автоматический deployment на целевую инфраструктуру

## Используемые технологии
- Yandex Cloud
- Terraform
- Ansible
- Docker
- Jenkins
- Python