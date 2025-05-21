build:
	docker compose up --build -d

up:
	docker compose up -d

stop:
	docker compose down

logs:
	docker compose logs -f

clean:
	@echo "Cleaning, if an error occurs, try using sudo" 
	docker compose down --volumes --remove-orphans
	rm -rf suricata-logs
