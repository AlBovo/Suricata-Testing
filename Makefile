build:
	docker compose up --build -d

up:
	docker compose up -d

stop:
	docker compose down

logs:
	docker compose logs -f

clean:
	docker compose down --volumes --remove-orphans
	sudo rm -rf suricata-logs/
	sudo rm -rf config/