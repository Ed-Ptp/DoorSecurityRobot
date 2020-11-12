#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/student/door-watcher/door_watcher_ws/src/dynamixel_motor-master/dynamixel_controllers"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/student/door-watcher/door_watcher_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/student/door-watcher/door_watcher_ws/install/lib/python2.7/dist-packages:/home/student/door-watcher/door_watcher_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/student/door-watcher/door_watcher_ws/build" \
    "/usr/bin/python2" \
    "/home/student/door-watcher/door_watcher_ws/src/dynamixel_motor-master/dynamixel_controllers/setup.py" \
     \
    build --build-base "/home/student/door-watcher/door_watcher_ws/build/dynamixel_motor-master/dynamixel_controllers" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/student/door-watcher/door_watcher_ws/install" --install-scripts="/home/student/door-watcher/door_watcher_ws/install/bin"
