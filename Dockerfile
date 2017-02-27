FROM jas99/alpine-glibc

RUN apk add --update --no-cache bash git curl openssl ca-certificates
RUN update-ca-certificates

# Install docker
ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.13.1
ENV DOCKER_SHA256 97892375e756fd29a304bd8cd9ffb256c2e7c8fd759e12a55a6336e15100ad75
RUN set -x \
	&& curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" -o docker.tgz \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v

# Install rocker
ENV ROCKER_VERSION "1.3.0"
RUN apk add --update --no-cache wget tar &&\
    wget --quiet --show-progress --progress=bar:force:noscroll https://github.com/grammarly/rocker/releases/download/${ROCKER_VERSION}/rocker_linux_amd64.tar.gz &&\
    tar -xvf rocker_linux_amd64.tar.gz --no-same-owner -C /usr/bin &&\
    chmod +x /usr/bin/rocker &&\
    rm rocker_linux_amd64.tar.gz

# Install docker-compose
RUN apk add --update --no-cache py-pip &&\
    pip install docker-compose


