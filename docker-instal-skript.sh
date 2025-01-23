#!/bin/bash

# Проверка на запуск от root
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите этот скрипт с правами root (с sudo)." >&2
  exit 1
fi

# Обновляем систему
sudo apt-get update  { echo "Ошибка обновления пакетов."; exit 1; }

# Устанавливаем зависимости
sudo apt-get install -y ca-certificates curl gnupg  { echo "Ошибка установки зависимостей."; exit 1; }

# Создаём каталог для ключей
sudo install -m 0755 -d /etc/apt/keyrings

# Скачиваем GPG-ключ Docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc  { echo "Ошибка скачивания GPG-ключа."; exit 1; }
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Добавляем репозиторий Docker
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null  { echo "Ошибка добавления репозитория."; exit 1; }

# Обновляем список пакетов
sudo apt-get update  { echo "Ошибка обновления списка пакетов."; exit 1; }

# Устанавливаем Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin  { echo "Ошибка установки Docker."; exit 1; }

# Добавляем текущего пользователя в группу docker
sudo usermod -aG docker $USER  { echo "Ошибка добавления пользователя в группу docker."; exit 1; }
echo "Docker установлен успешно. Для применения изменений перезайдите в систему."

# Проверяем установку
sudo docker run hello-world  { echo "Ошибка: Docker не работает корректно."; exit 1; }
