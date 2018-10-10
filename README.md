Buildroot overlay for WPE WebKit
================================

This repository contains documentation, tools, and build recipes to create
WPE packages for RPi devices, in the form of directory ready to use with
`BR2_EXTERNAL`.


Building
--------

Chose the appropriate “defconfig” for the target device (see list of [included
configurations](#included-configurations) below), and execute the following
from the top-level **Buildroot source tree** directory:

```sh
make BR2_EXTERNAL='path/to/buildroot-wpe' raspberrypi3_wpe_rdk_defconfig
make BR2_EXTERNAL='path/to/buildroot-wpe'
```

This will download the needed sources, configure Buildroot, compile WPE, and
store the build results under the `output/` subdirectory.


Configuring
-----------

To tune your build configuration use:

```sh
make BR2_EXTERNAL='…' menuconfig
```

Clean builds and config changes
-------------------------------

Buildroot does not attempt to automatically detect what you have changed on
the build config from the previous build. So if you are unsure about what
sould be rebuilt after a build config change or how to do that, then trigger
a complete new build from a clean state:

``` sh
make BR2_EXTERNAL='…' clean
make BR2_EXTERNAL='…'
```


Included Configurations
-----------------------

- `raspberrypi2_wpe_defconfig`: Produces an 1GB image file at
  `output/images/sdcard.img` for the Raspbrry Pi 2 with WPE. The image
  should be written to a SD card using a tool like `dd` or
  [etcher](https://etcher.io).

- `raspberrypi3_wpe_defconfig`: Produces an 1GB image file at
  `output/images/sdcard.img` for the Raspberry Pi 3 with WPE. The image
  should be wrote raw to the sdcard, using a tool like `dd` or
  [etcher](https://etcher.io)

- `raspberrypi3_wpe_rdk_defconfig`: Produces an 512MB image file at
  `output/images/sdcard.img` for the Raspberry Pi 3 with WPE woth WpeBackend-RDK and RPI-UserLand. The image
  should be wrote raw to the sdcard, using a tool like `dd` or
  [etcher](https://etcher.io)

Documentation
-------------

- [Buildroot's `BR2_EXTERNAL`](https://buildroot.org/downloads/manual/manual.html#outside-br-custom).

