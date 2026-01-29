start-dev:
	docker compose -f docker-compose-dev.yml up -d

show-dev-logs:
	docker compose -f docker-compose-dev.yml logs -f

stop-dev:
	docker compose -f docker-compose-dev.yml down	

start-pre-prod:
	docker compose -f docker-compose-pre-prod.yml  up -d

show-pre-prod-logs:
 	docker compose -f docker-compose-pre-prod.yml  logs -f

stop-pre-prod:
	docker compose -f docker-compose-pre-prod.yml down

run-certbot-try:
	docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ -v --dry-run -v backend.miksiei.fr --debug

run-certbot:
	docker compose run --rm certbot certonly --webroot --webroot-path /var/www/certbot/ -d backend.miksiei.fr
	
renew-certbot:
	docker compose run --rm certbot renew	