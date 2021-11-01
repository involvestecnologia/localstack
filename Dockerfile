FROM localstack/localstack:latest AS base
ARG bucket_name
COPY docker-entrypoint.sh /usr/local/bin/
COPY package.json package-lock.json index.js ./
RUN mkdir -p /docker-entrypoint-initaws.d/ && \
    echo "awslocal s3 mb s3://$bucket_name" >> /docker-entrypoint-initaws.d/setup.sh && \
    chmod +x /usr/local/bin/docker-entrypoint.sh && \
    npm install --no-audit

FROM base AS user-info
RUN echo "awslocal s3 mb s3://agilepromoter2-bucket01" > /docker-entrypoint-initaws.d/setup.sh && \
    echo "awslocal s3 cp /tmp/logo_cliente_login.png s3://agilepromoter2-bucket01/e2e/diversos/logo_cliente_login.png" >> /docker-entrypoint-initaws.d/setup.sh
COPY files/logo_cliente_login.png /tmp/logo_cliente_login.png
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

FROM base
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]