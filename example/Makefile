all:
	docker run --rm -v "$$PWD/out:/out" -v "$$PWD/data:/data:ro" rabbitofcaerbannog/hackmyresume-builder
	sudo chown -R $${USER}:users out

rocketspacer:
	docker run --rm -v "$$PWD/out:/out" -v "$$PWD/data:/data:ro" --env THEME_LIST=jsonresume-theme-rocketspacer rabbitofcaerbannog/hackmyresume-builder
	sudo chown -R $${USER}:users out

compose:
	docker-compose up
	sudo chown -R $${USER}:users out
