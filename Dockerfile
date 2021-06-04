FROM    centos:7

COPY    src/etc /etc

RUN     yum -y install epel-release
RUN     yum groups mark convert
RUN     yum --enablerepo=epel -y -x gnome-keyring --skip-broken groups install "Xfce" && \
RUN     yum -y install xrdp
RUN     yum -y clean all
RUN     rm /etc/xdg/autostart/at-spi-dbus-bus.desktop \
           /etc/xdg/autostart/caribou-autostart.desktop \
           /etc/xdg/autostart/xscreensaver.desktop \
           /etc/xdg/autostart/xfce4-power-manager.desktop \
           /etc/xdg/autostart/xfsettingsd.desktop \
           /etc/xdg/autostart/xfce-polkit.desktop
