FROM kalilinux/kali-linux-docker
MAINTAINER Ryan Ringler <rringler@gmail.com>


# Configure user for Xwindows
ENV USER root

RUN apt-get update
RUN apt-get install -y git python tightvncserver x11vnc xfce4  iceweasel-l10n-zh-tw
RUN git clone https://github.com/novnc/noVNC.git /root/noVNC
RUN git clone https://github.com/novnc/websockify.git /root/noVNC/utils/websockify

ADD nord /nord
RUN apt-get install -y openvpn
RUN apt-get install -y tmux

# Add Xwindows configuration
ADD .Xauthority /root/.Xauthority

# startup script
ADD startup.sh /startup.sh
ADD startVNC.sh /startVNC.sh
# RUN chmod 0755 /startup.sh

# SSH server
# RUN apt-get install -y openssh-server
# RUN mkdir /var/run/sshd
# RUN echo 'root:screencast' | chpasswd
# RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# # SSH login fix. Otherwise user is kicked off after login
# RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# ENV NOTVISIBLE "in users profile"
# RUN echo "export VISIBLE=now" >> /etc/profile

# Expose VNC & websockify ports

# ENTRYPOINT ["sh", "/startup.sh"]
EXPOSE 5901 6080
