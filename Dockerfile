FROM localstack/localstack:latest
ARG bucket_name
RUN mkdir -p /docker-entrypoint-initaws.d/
RUN echo "awslocal s3 mb s3://$bucket_name" >> /docker-entrypoint-initaws.d/setup.sh