#ENV NODE_VERSION 12.8.1-alpine

#FROM node:${NODE_VERSION}
FROM node:12.8.1-alpine

RUN apk add --no-cache git openssh-client
RUN apk add --no-cache 'su-exec>=0.2' bash
RUN apk add --no-cache tzdata
RUN npm install -g yarn
RUN yarn global add typescript hexo-cli

ENV TZ Asia/Taipei
ENV HEXO_FILE /hexo
ENV NODE_SSH_FILE /home/node/.ssh
ENV ROOT_SSH_FILE /root/.ssh

WORKDIR ${HEXO_FILE}

RUN echo "${TZ}" > /etc/timezone

RUN set -eux; \
# create .ssh file && chown node
    mkdir -p "${NODE_SSH_FILE}"; \
    chown node:node "${NODE_SSH_FILE}"; \
    mkdir -p "${ROOT_SSH_FILE}"; \
    chown node:node "${ROOT_SSH_FILE}"; \
# hexo init && add
    hexo init "${HEXO_FILE}"; \
    chown -R node:node "${HEXO_FILE}"; \
    su-exec node yarn add hexo-deployer-git hexo-generator-sitemap; \
# need to save initial hexo init file for pre-seeding empty volumes
    mv "${HEXO_FILE}" "${HEXO_FILE}.orig"; \
    mkdir -p "${HEXO_FILE}"; \
    chown -R node:node "${HEXO_FILE}"

#WORKDIR ${HEXO_FILE}
#VOLUME ${HEXO_FILE}



COPY ./docker-entrypoint.sh /usr/local/bin
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

#USER node

EXPOSE 4000
CMD ["node"]
