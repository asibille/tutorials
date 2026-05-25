FROM almalinux:9

RUN dnf install -y openssh-server python3 sudo tzdata \
    && dnf clean all \
    && ssh-keygen -A \
    && mkdir -p /var/run/sshd /run/sshd

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
