COMMAND=docker compose
APP_CONTAINER=app
CACHE=php artisan config:cache && php artisan route:cache && php artisan view:cache && php artisan cache:clear
RESET=cp .env.example .env && php artisan key:generate && php artisan config:cache && php artisan migrate

.PHONY: up
up:
	$(COMMAND) up -d

.PHONY: down
down:
	$(COMMAND) down

.PHONY: bash
bash:
	$(COMMAND) exec $(APP_CONTAINER) bash

.PHONY: pint
pint: 
	$(COMMAND) exec $(APP_CONTAINER) ./vendor/bin/pint $(args)

.PHONY: artisan
artisan: 
	$(COMMAND) exec $(APP_CONTAINER) php artisan $(args)

.PHONY: test
test:
	$(COMMAND) exec $(APP_CONTAINER) php artisan test $(args)

.PHONY: composer
composer: 
	$(COMMAND) exec $(APP_CONTAINER) composer $(args)

.PHONY: vendor
vendor: 
	$(COMMAND) exec $(APP_CONTAINER) composer install

.PHONY: php
php: 
	$(COMMAND) exec $(APP_CONTAINER) bash -c "$(RESET)"

.PHONY: cache
cache: 
	$(COMMAND) exec $(APP_CONTAINER) bash -c "$(CACHE)"

.PHONY: config-cache
config-cache: 
	$(COMMAND) exec $(APP_CONTAINER) php artisan config:cache

.PHONY: supervisor-reload
supervisor-reload:
	$(COMMAND) exec $(CLI_CONTAINER) bash -c "supervisorctl reload"
