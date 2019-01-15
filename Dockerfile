FROM golang:1.11

WORKDIR /opt
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

WORKDIR /opt
RUN git clone https://github.com/iden3/iden3js
WORKDIR /opt/iden3js
RUN npm i

WORKDIR /opt
RUN git clone https://github.com/iden3/go-iden3
WORKDIR /opt/go-iden3
RUN git checkout feature/passwd
ENV GO111MODULE on
RUN go build -o ./relay cmd/relay/main.go

WORKDIR /opt
COPY . .

ARG RELAY2I_WEB3_URL
ENV RELAY2I_WEB3_URL=$RELAY2I_WEB3_URL

ARG RELAY2I_KEYSTORE_PASSWORD
ENV RELAY2I_KEYSTORE_PASSWORD=$RELAY2I_KEYSTORE_PASSWORD

RUN ./run.sh
