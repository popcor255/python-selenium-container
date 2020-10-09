# Activate Headless Display (Xvfb)
Xvfb :99 -screen 0 640x480x8 -nolisten tcp &
export DISPLAY=:99
