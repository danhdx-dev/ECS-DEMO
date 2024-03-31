#!/bin/bash

# Sao chép file .env.example thành .env
cp .env.example .env
echo "Copied .env.example to .env"
cat .env
composer install && php artisan key:generate && chmod 777 -R storage/