FROM localstack/localstack:latest
ARG bucket_name
RUN mkdir -p /docker-entrypoint-initaws.d/
RUN echo "awslocal s3 mb s3://$bucket_name" >> /docker-entrypoint-initaws.d/setup.sh
RUN rm /usr/local/bin/docker-entrypoint.sh
ADD docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

COPY package.json package-lock.json index.js ./

RUN --mount=type=cache,uid=1000,gid=1000,target=/home/node/.npm \
    npm install --no-audit

# define command at startup
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]