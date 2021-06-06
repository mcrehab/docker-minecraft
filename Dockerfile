#
# Inherit from the official centos docker image.
#
FROM    centos:8

#
# Copy the files in the local "src" directory in to the image.
#
COPY    src/etc /etc
COPY    src/bin /bin
COPY    entrypoint.sh .

#
# Install packages in the centos image.
#
RUN     yum -y install epel-release
RUN     yum --enablerepo=epel -y -x gnome-keyring --skip-broken groups install "Development Tools"
RUN     yum --enablerepo=epel -y -x gnome-keyring --skip-broken groups install "Xfce"
RUN     yum -y install xrdp \
                       wget \
                       java \
                       bzip2 \
                       python3 \
                       tigervnc-server

RUN     yum -y clean all
RUN     pip3 install numpy

#
# Remove default settings for when xfce desktop is started.
#
RUN     rm -f /etc/xdg/autostart/at-spi-dbus-bus.desktop \
              /etc/xdg/autostart/caribou-autostart.desktop \
              /etc/xdg/autostart/xscreensaver.desktop \
              /etc/xdg/autostart/xfce4-power-manager.desktop \
              /etc/xdg/autostart/xfsettingsd.desktop \
              /etc/xdg/autostart/xfce-polkit.desktop


#
# Add wget with slected minecraft jar ex ; https://launcher.mojang.com/download/Minecraft.tar.gz (Minecraft 1.16.5)
#
WORKDIR /build
RUN wget https://launcher.mojang.com/download/Minecraft.tar.gz
RUN tar -xvzf Minecraft.tar.gz
RUN cp minecraft-launcher/minecraft-launcher /usr/local/bin

#
# Create the default user..
#
RUN adduser minecraft
RUN echo minecraft:minecraft | chpasswd
RUN echo "xfce4-session" > /home/minecraft/.xsession
RUN echo "exec /usr/bin/startxfce4" > /home/minecraft/.Xclients
RUN chmod +x /home/minecraft/.Xclients

COPY src/home/ /home
RUN chown -R minecraft /home/minecraft

WORKDIR /home/minecraft/world

RUN wget https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar

WORKDIR /home/minecraft/novnc
RUN wget https://github.com/novnc/noVNC/archive/refs/tags/v1.2.0.tar.gz && \
    tar -xvzf v1.2.0.tar.gz && \
    rm -rf v1.2.0.tar.gz
#

# Run this when the docker container is started..
#
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
