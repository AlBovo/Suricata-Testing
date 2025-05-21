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

test:
	@echo "Running tests..."
	docker exec malicious_service sh -c "./run_scripts.sh"
	@echo "Tests completed."

test-internal:
	docker exec service1 sh -c "./tmNIDS.sh"

shell-suricata:
	docker exec -it suricata bash

shell-service1:
	docker exec -it service1 sh

shell-service2:
	docker exec -it service2 sh

