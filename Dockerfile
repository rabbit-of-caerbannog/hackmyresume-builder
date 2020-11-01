FROM mhart/alpine-node:latest
MAINTAINER Erik Stidham <estidham@gmail.com>

# Install wkthml2pdf
RUN apk update && \
    apk add --no-cache \
        rsync \
		    xvfb \
# Additionnal dependencies for better rendering
			ttf-freefont \
			fontconfig \
            dbus \
    && \
# needed for pdf generation
    apk add --no-cache wkhtmltopdf \
            --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
            --allow-untrusted \
    && \
    mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin && \
    echo $'#!/usr/bin/env sh\n\
    Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \n\
    DISPLAY=:0.0 wkhtmltopdf-origin --page-size ${PAGE_SIZE:-Letter} $@ \n\
    killall Xvfb\
    ' > /usr/bin/wkhtmltopdf && \
    chmod +x /usr/bin/wkhtmltopdf && \
# Update npm
	npm install -g npm@latest && \
# Install hackmyresume
	npm install -g hackmyresume && \
	for x in $(\
		# Needed to not run out of heap space for npm search
		node --max-old-space-size=4000 \
		# Search for all themes
		/usr/bin/npm search jsonresume-theme --parseable | \
		# Filter non-themes and cut just the name of the package
      grep "^jsonresume-theme-"  | cut -f1); \
	do \
		npm install $x; \
	done && \
	for x in $(\
		# Needed to not run out of heap space for npm search
		node --max-old-space-size=4000 \
		# Search for all themes
		/usr/bin/npm search fresh-theme --parseable | \
		# Filter non-themes and cut just the name of the package
      grep "^fresh-theme-"  | cut -f1); \
	do \
		npm install $x; \
	done && \
	rm -rf /root/.npm && \
  rm -rf /var/cache/apk/*

COPY example/data/resume.json example/data/picture.png /example/
COPY scripts/build /build

CMD ["/build"]
