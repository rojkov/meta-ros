DESCRIPTION = "ROS driver for RealSense camera"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://package.xml;beginline=11;endline=11;md5=4bcd5f0e140091c68f8c0bcfdd6181e0"

DEPENDS = "librealsense cv-bridge camera-info-manager pcl-ros roscpp roslint-native"

SRC_URI = "https://github.com/intel-ros/realsense/archive/${PV}.tar.gz \
           "
SRC_URI[md5sum] = "aa05cdda5c6952cf0b4125f040048b81"

S = "${WORKDIR}/realsense-${PV}/realsense_camera"

inherit catkin

EXTRA_OECMAKE = "-DUSE_SYSTEM_LIBREALSENSE:BOOL=ON"
