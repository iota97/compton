# Compton with custom GLSL shader instead of blur effect

## Building

### Dependencies:

__B__ for build-time

__R__ for runtime

* libx11 (B,R)
* libxcomposite (B,R)
* libxdamage (B,R)
* libxfixes (B,R)
* libXext (B,R)
* libxrender (B,R)
* libXrandr (B,R)
* libXinerama (B,R) (Can be disabled with `NO_XINERAMA` at compile time)
* pkg-config (B)
* make (B)
* xproto / x11proto (B)
* sh (R)
* xprop,xwininfo / x11-utils (R)
* libpcre (B,R) (Can be disabled with `NO_REGEX_PCRE` at compile time)
* libconfig (B,R) (Can be disabled with `NO_LIBCONFIG` at compile time)
* libdrm (B) (Can be disabled with `NO_VSYNC_DRM` at compile time)
* libGL (B,R) (Can be disabled with `NO_VSYNC_OPENGL` at compile time)
* libdbus (B,R) (Can be disabled with `NO_DBUS` at compile time)
* asciidoc (B) (and docbook-xml-dtd-4.5, libxml-utils, libxslt, xsltproc, xmlto, etc. if your distro doesn't pull them in)

### How to build

To build, make sure you have the dependencies above:

```bash
# Make the main program
$ make
# Make the man pages
$ make docs
# Install
$ make install
```

## Usage

you may skip step 1 to 4 and use sample config ```compton.sample.conf```

1) Set backend to glx in the config
2) Enable blur in the config
3) Set ```shader-path``` in the config
4) Write your own shader or use the one in ```shaders``` folder
5) Disable other running compositor
6) Run with ```compton --config /path/to/config.conf -b```

## Previews

![bw](/previews/bw.png)

![boken](/previews/boken.png)

![rain](/previews/rain.gif)

![1337](/previews/1337.png)

![abberation](/previews/abberation.png)

![pixelize](/previews/pixelize.png)
