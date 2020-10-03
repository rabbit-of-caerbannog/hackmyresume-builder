# hackmyresume-builder

Dockerized HackMyResume with all themes installed.

# What and Why

HackMyResume is a nice tool that renders your JSON resume according to a template. These templates can be available as node modules and several of them exist. It's not trivial to hunt down each one, install them, render it, just to get a glimpse at it. This repository intends to relief that pain with a few things:

- A [static page](https://rabbit-of-caerbannog.github.io/hackmyresume-builder/) with an example output directory with the multiple generated pages. Uses sample data from `example/`.
- A [docker image](https://hub.docker.com/r/rabbitofcaerbannog/hackmyresume-builder) with `hackmyresume` and all themes from npm installed and a few other defaults, that'll see ahead.
- A repository that you can clone, run make, Ctrl-C, edit, make and so on, to quickly iterate on your JSON resume without thinking about dependencies.

# Quickstart

```
git clone https://github.com/rabbit-of-caerbannog/hackmyresume-builder
cd hackmyresume-builder/example
make
```

This will get you up and started. Just tweak the data inside `example/data` to your liking and keep `make`ing until you like what you see. Includes a `docker-compose` for those who prefer it.


# Usage

If you just want to take a quick run at it and see the results, you can run the following command:

```
docker run --rm -v "$PWD/out":/out rabbitofcaerbannog/hackmyresume-builder
```

The `out` volume is always required to keep the docker generated files. They'll also be owned by root, so you probably also want to always run `sudo chown -R "$USER:$USER" out` afterwards.


Once you have your `resume.json` (and whatever pictures/assets you need), you put them up in a folder and mount them as well. We can mount it as read-only to make sure it doesn't mess with our stuff.

```
docker run --rm -v "$PWD/out:/out" -v "$PWD/data:/data:ro" rabbitofcaerbannog/hackmyresume-builder
```

Finally, if you've chosen one or more themes that you want to build, you can pass the `THEME_LIST` environment variable.
```
docker run --rm -v "$PWD/out:/out" -v "$PWD/data:/data:ro" --env THEME_LIST=jsonresume-theme-rocketspacer,jsonresume-theme-even rabbitofcaerbannog/hackmyresume-builder
```

## Credit Due

This Dockerfile was based on [tmjd/docker-hackmyresume](https://github.com/tmjd/docker-hackmyresume).  
The above Dockerfile was based on [alrayyes/docker-alpine-hackmyresume-bash](https://github.com/alrayyes/docker-alpine-hackmyresume-bash).
