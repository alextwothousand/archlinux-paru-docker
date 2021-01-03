# metadata
FROM archlinux:base-devel
LABEL maintainer="alexdev <infinityen@protonmail.com>"

# update packages and install git
RUN \
	pacman -Syyu --needed --noconfirm && \
	pacman -S git --needed --noconfirm
	
# create makepkg user
ARG user=makepkg
RUN \
	useradd -m ${user} && \
	echo "${user} ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/${user}
	
# switch to our new user
USER ${user}
WORKDIR /home/${user}

# install paru
RUN \
    git clone https://aur.archlinux.org/paru.git && \
    cd paru && \
    makepkg -si --needed --noconfirm
