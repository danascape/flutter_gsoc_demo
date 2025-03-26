# Demo GSoC Flutter App

This is a basic basic flutter app that displays a persons name and an image when we click the button.

This app was created as part of AGL GSoC 2025 quiz.

## AGL Integration Details

Following steps were taken to integrate this app into AGL image.

### 1. Build AGL locally
The 'agl-ivi-demo-flutter' of AGL salmon branch was built locally and tested using QEMU.

### 2. Add Yocto recipe for our flutter app
Under the `recipes-sdk` folder i created a new directory named `flutter_gsoc_demo`. The flutter_gsoc_demo has `.bb` file containing following recipe:
```
SUMMARY = "Flutter GSoC Demo Application"
DESCRIPTION = "A Flutter based IVI Application"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"
SECTION = "graphics"

SRC_URI = "git://github.com/danascape/flutter_gsoc_demo.git;branch=master;protocol=https \
           file://agl-app-flutter@flutter-gsoc-demo.service \
           "

SRCREV = "3beb92592eee737a96d7f258066f2d9b85d641ed"
S = "${WORKDIR}/git"

inherit flutter-app

# flutter-app
PUBSPEC_APPNAME = "flutter_gsoc_demo"
PUBSPEC_IGNORE_LOCKFILE = "1"
FLUTTER_BUILD_ARGS = "bundle -v"

do_install:append() {
    install -D -m 0644 ${WORKDIR}/agl-app-flutter@flutter-gsoc-demo.service ${D}${systemd_system_unitdir}/agl-app-flutter@flutter-gsoc-demo.service
}

do_compile[network] = "1"
```

### 3. Add recipe in the environment
In order to display our app inside the IVI we need to include it inside `recipes-platform` packagegroups. The `packagegroup-agl-demo-platform-flutter.bb` file was updated as follows:

```
$ bitbake-layers add-layer ../meta-gsoc-demo
```

### 4. Build the image to again
In order for our changes to be reflected we need to re-build the updated recipes and then build the entire image again. Following commands will acheive this:
```
$ source agl-init-build-env
$ bitbake flutter_gsoc_demo
$ bitbake agl-ivi-demo-flutter
```
This will take a couple of minutes depending upon system speed.

### 5. Running our image using qemu
Now its time to see if our newly added app works as intended or not. We'll run the following command to boot the image:
```
$ runqemu kvm serialstdio slirp publicvnc
```
The AGL image is running in background, we can use vncviewer to open it.
