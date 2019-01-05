FROM centos:7

ENV GIT_VERSION tweaks

MAINTAINER Brian Dwyer

RUN mkdir -p /go/bin && chmod -R 777 /go && cd /go \
		&& yum -y update \
		&& yum install -y centos-release-scl \
		&& yum -y install git \
		  openssl-devel systemd-devel \
  		go-toolset-7-golang \
		&& yum clean all

ENV GOPATH=/go \
		GOOS=linux \
		BASH_ENV=/opt/rh/go-toolset-7/enable \
		ENV=/opt/rh/go-toolset-7/enable \
		PROMPT_COMMAND=". /opt/rh/go-toolset-7/enable"

WORKDIR /go/src

RUN git clone -b ${GIT_VERSION} https://github.com/bdwyertech/journald-cloudwatch-logs \
		&& cd journald-cloudwatch-logs \
		&& . /opt/rh/go-toolset-7/enable \
		&& go get \
		&& go build

FROM centos:7

COPY --from=0 /go/src/journald-cloudwatch-logs/journald-cloudwatch-logs /usr/bin/
