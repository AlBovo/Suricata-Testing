build:
	docker compose up --build -d

up:
	docker compose up -d

stop:
	docker compose down

logs:
	docker compose logs -f

shell:
	ifndef SERVICE
		$(error Usage: make shell SERVICE=<container_name or id>)
	endif
		docker exec -it $(SERVICE) /bin/sh || docker exec -it $(SERVICE) /bin/bash

clean:
	@echo "Cleaning, if an error occurs, try using sudo" 
	docker compose down --volumes --remove-orphans
	rm -rf suricata-logs
