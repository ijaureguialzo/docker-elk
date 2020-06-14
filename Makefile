help:
	@echo "Opciones:"
	@echo "  start | start-extra | stop | restart | stop-all"
	@echo "  mosquitto"
	@echo "  stats | update | clean"

_start-command:
	@docker-compose up -d --remove-orphans

_start-command-extra:
	@docker-compose -f docker-compose.yml -f docker-compose.extra.yml up -d --remove-orphans

start: _start-command _urls-head _urls-base _urls-footer

start-extra: _start-command-extra _urls-head _urls-base _urls-extra _urls-footer

stop:
	@docker-compose -f docker-compose.yml -f docker-compose.extra.yml stop

restart: stop start

stop-all:
	@docker stop `docker ps -aq`

mosquitto:
	@docker-compose -f docker-compose.yml -f docker-compose.extra.yml exec mosquitto /bin/sh

stats:
	@docker stats

update:
	@docker-compose -f docker-compose.yml -f docker-compose.extra.yml pull
	@docker-compose -f docker-compose.yml -f docker-compose.extra.yml build --pull

clean:
	@docker-compose -f docker-compose.yml -f docker-compose.extra.yml down -v --remove-orphans

_urls-head:
	@echo ""
	@echo "--------------------"

_urls-footer:
	@echo "--------------------"

_urls-base:
	@echo "[Kibana] http://localhost:5601"

_urls-extra:
