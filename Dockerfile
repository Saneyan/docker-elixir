FROM base/archlinux:latest

MAINTAINER TADOKORO Saneyuki saneyan@gfunction.com

RUN curl 'https://www.archlinux.org/mirrorlist/?country=JP&protocol=http&ip_version=4' | sed -e 's/^#Server/Server/' > /etc/pacman.d/mirrorlist

COPY ./pacman-repo.conf /root/pacman-repo.conf
RUN cat /root/pacman-repo.conf >> /etc/pacman.conf

RUN sed -i 's/SigLevel.*/SigLevel = Never/g' /etc/pacman.conf

RUN pacman -Syu --noconfirm
RUN pacman-db-upgrade
RUN pacman -S --noconfirm sudo yaourt git vim openssh elixir

RUN sed -i 's/^# %sudo.*/%sudo ALL=(ALL) NOPASSWD:ALL/' /etc/sudoers

RUN groupadd sudo
RUN useradd -m -G sudo -s /usr/bin/bash -b /home saneyan

RUN sudo -u saneyan yaourt -Syua --noconfirm

CMD ["bash"]
