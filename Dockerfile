FROM hashicorp/terraform:0.14.2

RUN apk add -U \
  bash build-base curl \
  libffi-dev py3-pip python3-dev \
  zip git openssh-client

ENV TERRAGRUNT_VER v0.27.3
RUN curl -o /bin/terragrunt -L "https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VER}/terragrunt_linux_amd64" \
  && chmod u+x /bin/terragrunt

RUN mkdir -p ~/.ssh && \
    ssh-keyscan -H github.com > ~/.ssh/known_hosts

COPY requirements.txt .
RUN ln -s /usr/bin/python3 /usr/bin/python \
  && pip install --upgrade pip \
  && pip install -r requirements.txt

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
