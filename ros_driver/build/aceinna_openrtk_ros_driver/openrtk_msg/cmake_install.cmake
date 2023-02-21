# Install script for directory: /home/oskar/aceinna-rtk/ros_driver/src/aceinna_openrtk_ros_driver/openrtk_msg

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/oskar/aceinna-rtk/ros_driver/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/openrtk_msg/msg" TYPE FILE FILES
    "/home/oskar/aceinna-rtk/ros_driver/src/aceinna_openrtk_ros_driver/openrtk_msg/msg/openrtk_imu.msg"
    "/home/oskar/aceinna-rtk/ros_driver/src/aceinna_openrtk_ros_driver/openrtk_msg/msg/openrtk_gnss.msg"
    "/home/oskar/aceinna-rtk/ros_driver/src/aceinna_openrtk_ros_driver/openrtk_msg/msg/openrtk_ins.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/openrtk_msg/cmake" TYPE FILE FILES "/home/oskar/aceinna-rtk/ros_driver/build/aceinna_openrtk_ros_driver/openrtk_msg/catkin_generated/installspace/openrtk_msg-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/oskar/aceinna-rtk/ros_driver/devel/include/openrtk_msg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/oskar/aceinna-rtk/ros_driver/devel/share/roseus/ros/openrtk_msg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/oskar/aceinna-rtk/ros_driver/devel/share/common-lisp/ros/openrtk_msg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/oskar/aceinna-rtk/ros_driver/devel/share/gennodejs/ros/openrtk_msg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/oskar/aceinna-rtk/ros_driver/devel/lib/python3/dist-packages/openrtk_msg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/oskar/aceinna-rtk/ros_driver/devel/lib/python3/dist-packages/openrtk_msg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/oskar/aceinna-rtk/ros_driver/build/aceinna_openrtk_ros_driver/openrtk_msg/catkin_generated/installspace/openrtk_msg.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/openrtk_msg/cmake" TYPE FILE FILES "/home/oskar/aceinna-rtk/ros_driver/build/aceinna_openrtk_ros_driver/openrtk_msg/catkin_generated/installspace/openrtk_msg-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/openrtk_msg/cmake" TYPE FILE FILES
    "/home/oskar/aceinna-rtk/ros_driver/build/aceinna_openrtk_ros_driver/openrtk_msg/catkin_generated/installspace/openrtk_msgConfig.cmake"
    "/home/oskar/aceinna-rtk/ros_driver/build/aceinna_openrtk_ros_driver/openrtk_msg/catkin_generated/installspace/openrtk_msgConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/openrtk_msg" TYPE FILE FILES "/home/oskar/aceinna-rtk/ros_driver/src/aceinna_openrtk_ros_driver/openrtk_msg/package.xml")
endif()

