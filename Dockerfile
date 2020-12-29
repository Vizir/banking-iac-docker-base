FROM alpine:3.12.0

RUN apk add -U \
  bash build-base curl \
  libffi-dev py3-pip python3-dev \
  zip git openssh-client

RUN mkdir -p ~/.ssh && \
    ssh-keyscan -H github.com > ~/.ssh/known_hosts

RUN ln -s /usr/bin/python3 /usr/bin/python

ENV TERRAFORM_VER 0.14.2
ENV TERRAFORM_ZIP terraform_${TERRAFORM_VER}_linux_amd64.zip

RUN curl -o /tmp/${TERRAFORM_ZIP} https://releases.hashicorp.com/terraform/${TERRAFORM_VER}/${TERRAFORM_ZIP} \
  && unzip /tmp/${TERRAFORM_ZIP} -d /usr/local/bin \
  && rm /tmp/${TERRAFORM_ZIP}

COPY requirements.txt .

RUN pip install --upgrade pip \
  && pip install -r requirements.txt
