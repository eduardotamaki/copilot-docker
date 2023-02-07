FROM ubuntu:22.04 as copilot-base

RUN apt update

RUN apt install curl openjdk-8-jdk git nodejs unzip python3 -y

WORKDIR /var/apps/aws-cli

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

RUN unzip awscliv2.zip

RUN ./aws/install

WORKDIR /var/apps/copilot

RUN curl -Lo copilot https://github.com/aws/copilot-cli/releases/latest/download/copilot-linux && chmod +x copilot && mv copilot /usr/local/bin/copilot && copilot --help

FROM copilot-base

WORKDIR /var/workspace

COPY pipe.sh .

CMD ["pipe.sh"]