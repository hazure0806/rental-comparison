FROM node:20.15.0-slim

ENV USER_NAME=node
ENV USER_UID=1000
ARG wkdir=/home/${USER_NAME}/app

RUN apt-get update && apt-get install -y \
    sudo curl vim wget procps \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Change language and timezone (UTC -> JST)
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

WORKDIR ${wkdir}

RUN echo "root:root" | chpasswd \
    && usermod -aG sudo ${USER_NAME} \
    && echo "${USER_NAME}:${USER_NAME}" | chpasswd \
    && echo "%${USER_NAME}    ALL=(ALL)    NOPASSWD:    ALL" >> /etc/sudoers.d/${USER_NAME} \
    && chmod 0440 /etc/sudoers.d/${USER_NAME} \
    && chown -hR ${USER_NAME}:${USER_NAME} ${wkdir}

USER ${USER_NAME}

COPY ./app/ /home/${USER_NAME}/app/

# Ensure the correct ownership and permissions for the copied files
RUN sudo chown -R ${USER_NAME}:${USER_NAME} /home/${USER_NAME}/app \
    && sudo chmod -R 755 /home/${USER_NAME}/app

RUN yarn install

# RUN yarn build

# CMD [ "yarn", "start" ]
