FROM devtools-docker.artifactory.eng.vmware.com/vmware/butler/container-cloud/jnlp:3.27-1

USER root

RUN sed -i -e 's/deb.debian.org/mirrors.huaweicloud.com/g' /etc/apt/sources.list && \
    sed -i -e 's/security.debian.org/mirrors.huaweicloud.com/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && \
    apt-get clean

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
   add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable" && \
   apt-get update && \
   apt-get install -y docker-ce && \
   apt-get clean

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - && apt-get install -y nodejs

RUN wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz && \
    tar xvf go1.13.3.linux-amd64.tar.gz && mv go /usr/local && \
    ln -s /usr/local/go/bin/* /usr/local/bin && \
    rm go1.13.3.linux-amd64.tar.gz

RUN echo 'jenkins ALL=(ALL) NOPASSWD:/usr/bin/docker' > /etc/sudoers.d/jenkins

ENV GOPATH=/home/jenkins/go

USER jenkins
