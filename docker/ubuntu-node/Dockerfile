FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server python3 sudo tzdata \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/run/sshd \
    && mkdir -p /run/sshd

RUN useradd -m -s /bin/bash ansible \
    && echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && mkdir -p /home/ansible/.ssh \
    && chmod 700 /home/ansible/.ssh

ARG SSH_PUB_KEY="ssh-rsa placeholder"
RUN echo "${SSH_PUB_KEY}" > /home/ansible/.ssh/authorized_keys \
    && chmod 600 /home/ansible/.ssh/authorized_keys \
    && chown -R ansible:ansible /home/ansible/.ssh

RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && echo "AllowUsers ansible" >> /etc/ssh/sshd_config

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-e"]
