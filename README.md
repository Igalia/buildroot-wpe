Buildroot overlay for WPE on RPi
================================

This repository contains documentation, tools, and build recipes to create
WPE packages for RPi devices, in the form of directory ready to use with
`BR2_EXTERNAL`.

**This does not work.** It is an abandoned WIP project. If you can figure out
how to get it to work, that would be cool.

Building
--------

Chose the appropriate “defconfig” for the target device (see list of [included
configurations](#included-configurations) below), and execute the following
from the top-level source tree directory:

```sh
make rpi3_wpe_pkg_defconfig
make
```

This will download the needed sources, configure Buildroot, compile WPE, and
produce store the build results under the `output/` subdirectory.


Configuring
-----------

To tune your build configuration use:

```sh
make menuconfig
```

Clean builds and config changes
-------------------------------

Buildroot does not attempt to automatically detect what you have changed on
the build config from the previous build. So if you are unsure about what
sould be rebuilt after a build config change or how to do that, then trigger
a complete new build from a clean state:

``` sh
make clean && make
```


Included Configurations
-----------------------

- `rpi2_wpe_pkg_defconfig`: Produces an 1GB image file at output/images/sdcard.img
   for the RPi2 with WPE. The image should be wrote raw to the sdcard, using a tool
   like ``dd`` or [etcher](https://etcher.io)
- `rpi3_wpe_pkg_defconfig`: Produces an 1GB image file at output/images/sdcard.img
   for the RPi3 with WPE. The image should be wrote raw to the sdcard, using a tool
   like ``dd`` or [etcher](https://etcher.io)


Documentation
-------------

- [Buildroot's `BR2_EXTERNAL`](https://buildroot.org/downloads/manual/manual.html#outside-br-custom).

