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
