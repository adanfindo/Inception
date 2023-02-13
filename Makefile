NAME	= inception
SRC_DIR	= srcs
ENV		= $(SRC_DIR)/.env
YML		= $(SRC_DIR)/docker-compose.yml
USER	= tde-nico

D		= sudo docker
DC		= sudo docker-compose
RM		= sudo rm -rf
MD		= sudo mkdir -p

IMAGES	= $(shell sudo docker images -qa)
VOLUMES	= $(shell sudo docker volume ls -q)



all: start

host:
	@ sudo echo "127.0.0.1 $(USER).42.fr" >> /etc/hosts

dirs: clean_dir
	@ $(MD) /home/$(USER)/data
	@ $(MD) /home/$(USER)/data/mariadb
	@ $(MD) /home/$(USER)/data/wordpress

start:
	@ $(DC) --env-file $(ENV) -f $(YML) up

stop:
	@ $(DC) --env-file $(ENV) -f $(YML) down

re: fclean reload
	
reload:
	@ $(DC) --env-file $(ENV) -f $(YML) up --build


#####   CLEAN   #####


clean: stop
	@ $(D) system prune -a -f

fclean: clean clean_vol dirs

clean_vol:
	@ $(D) volume rm $(VOLUMES)

clean_dir:
	@ $(RM) /home/$(USER)/data

clean_image:
	@ $(D) rmi -f $(IMAGES)

clean_mac:
	@ find . -name "*._*" -delete
	@ find . -name "*.DS_Store" -delete


#####   UTILS   #####


tar:
	@ tar -cf ../$(NAME).tar .

setup: host
	@ sudo apt install -y git docker docker.io docker-compose
	@ sudo service docker restart

unix:
	find . -type f -print0 | xargs -0 dos2unix --


.PHONY: all host dirs start stop re reload clean fclean clean_vol clean_dir clean_image clean_mac tar setup
