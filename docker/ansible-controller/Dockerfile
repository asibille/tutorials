FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ansible openssh-client python3 python3-pip curl unzip \
    && pip3 install pywinrm \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip \
    -o /tmp/tf.zip && unzip /tmp/tf.zip -d /usr/local/bin/ && rm /tmp/tf.zip

RUN mkdir -p /root/.ssh \
    && ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -N "" \
    && chmod 700 /root/.ssh && chmod 600 /root/.ssh/id_rsa

WORKDIR /ansible
