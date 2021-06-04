#
# Inherit from the official centos docker image.
#
FROM    centos:7

#
# Copy the files in the local "src" directory in to the image.
#
COPY    src/etc /etc

#
# Install packages in the centos image.
#
RUN     yum -y install epel-release
RUN     yum groups mark convert
RUN     yum --enablerepo=epel -y -x gnome-keyring --skip-broken groups install "Xfce"
RUN     yum -y install xrdp
RUN     yum -y install wget
RUN     yum -y clean all


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

#
# Create the default user..
#
RUN adduser minecraft
RUN echo minecraft:minecraft | chpasswd
RUN echo "xfce4-session" > /home/minecraft/.xsession
RUN echo "exec /usr/bin/startxfce4" > /home/minecraft/.Xclients
RUN chmod +x /home/minecraft/.Xclients

#
# Run this when the docker container is started..
#
WORKDIR /
COPY entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
