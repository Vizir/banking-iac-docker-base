FROM hashicorp/terraform:0.14.7

RUN apk add -U \
  bash \
  build-base \
  curl \
  git \
  libffi-dev \
  openssh \
  py3-pip \
  python3-dev \
  zip

ENV TERRAGRUNT_VER 0.28.6
RUN curl -o /bin/terragrunt -L "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VER}/terragrunt_linux_amd64" \
  && chmod u+x /bin/terragrunt

RUN mkdir -p ~/.ssh \
  && ssh-keyscan -H github.com > ~/.ssh/known_hosts

COPY requirements.txt .
RUN ln -s /usr/bin/python3 /usr/bin/python \
  && pip install --upgrade pip \
  && pip install -r requirements.txt

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
