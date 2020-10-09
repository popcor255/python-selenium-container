FROM python:3.9.0-buster
COPY . .
#==============
# VNC and Xvfb
#==============
RUN apt-get update -y && apt-get -y install xvfb 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y keyboard-configuration
RUN apt-get install -y build-essential chrpath libssl-dev libxft-dev
RUN apt-get install -y libfreetype6 libfreetype6-dev
RUN apt-get install -y libfontconfig1 libfontconfig1-dev
RUN apt-get install -y unzip
RUN apt-get install -y xserver-xorg-core
RUN apt-get install -y x11-xkb-utils
RUN apt-get install -y xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic libappindicator1 lsb-release
RUN apt-get install -y fonts-liberation libatk-adaptor libgail-common libgtk-3-0 libxcomposite1 libxrandr2 xdg-utils
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*


#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Java programs
#========================
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    bzip2 \
    ca-certificates \
    default-jre \
    sudo \
    unzip \
    wget \
    libgconf-2-4

#==========
# Selenium
#==========
RUN  mkdir -p /opt/selenium \
  && wget --no-verbose https://selenium-release.storage.googleapis.com/3.1/selenium-server-standalone-3.1.0.jar -O /opt/selenium/selenium-server-standalone.jar

#========================================
# Add normal user with passwordless sudo
#========================================
RUN sudo useradd bot --shell /bin/bash --create-home \
  && sudo usermod -a -G sudo bot \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'bot:secret' | chpasswd

USER root

# Install Chrome
RUN wget http://www.slimjetbrowser.com/chrome/lnx/chrome64_65.0.3325.181.deb
RUN apt-get -f install -y --force-yes
RUN dpkg -i chrome64_65.0.3325.181.deb

# Install Chromedriver
RUN wget -N http://chromedriver.storage.googleapis.com/2.36/chromedriver_linux64.zip
RUN unzip -o chromedriver_linux64.zip
RUN chmod +x chromedriver
RUN rm -f /usr/local/share/chromedriver
RUN rm -f /usr/local/bin/chromedriver
RUN rm -f /usr/bin/chromedriver
RUN mv -f chromedriver /usr/local/share/chromedriver
RUN ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver
RUN ln -s /usr/local/share/chromedriver /usr/bin/chromedriver

RUN chown -R bot:bot /opt/selenium
RUN mkdir /tmp/.X11-unix 
RUN chmod 1777 /tmp/.X11-unix 
RUN chown root /tmp/.X11-unix/


# Following line fixes
# https://github.com/SeleniumHQ/docker-selenium/issues/87
RUN echo "DBUS_SESSION_BUS_ADDRESS=/dev/null" >> /etc/environment
RUN pip install -r /requirements.txt

USER bot

RUN sudo chown bot:bot /app
RUN sudo chown bot:bot /home/bot

CMD bash /hack/scripts/start_headless.sh && python -u /app/app.py