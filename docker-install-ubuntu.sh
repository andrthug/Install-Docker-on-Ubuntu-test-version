#!/bin/bash

# Обновляем систему
sudo apt-get update

# Устанавливаем зависимости
sudo apt-get install -y ca-certificates curl

# Создаём каталог для ключей
sudo install -m 0755 -d /etc/apt/keyrings

# Скачиваем GPG-ключ Docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Добавляем репозиторий Docker
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Обновляем список пакетов
sudo apt-get update

# Установка пакетов Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Убедитесь, что установка прошла успешно, запустив образ hello-world
sudo docker run hello-world
