FROM kalilinux/kali-linux-docker
MAINTAINER Ryan Ringler <rringler@gmail.com>


# Configure user for Xwindows
ENV USER root

RUN apt-get update
RUN apt-get install -y git python tightvncserver x11vnc xfce4  iceweasel-l10n-zh-tw
RUN git clone https://github.com/novnc/noVNC.git /root/noVNC
RUN git clone https://github.com/novnc/websockify.git /root/noVNC/utils/websockify

RUN apt-get install -y openvpn
RUN apt-get install -y tmux

# Add Xwindows configuration
ADD .Xauthority /root/.Xauthority

ADD scripts /scripts
# ADD setVPN.sh /scripts/setVPN.sh
# ADD startVNC.sh /scripts/startVNC.sh
# RUN chmod 0755 /startup.sh

# SSH server
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
# RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config


# ENV NOTVISIBLE "in users profile"
# RUN echo "export VISIBLE=now" >> /etc/profile

# Expose VNC & websockify ports

# CMD ["sh", "/scripts/startup.sh"]
EXPOSE 5901 6080 22

