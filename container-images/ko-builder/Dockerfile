ARG GO_RELEASE
FROM docker.elastic.co/ci-agent-images/basic-buildkite-agent:latest as fetcher
ARG KO_RELEASE

ADD --chmod=755 https://github.com/slsa-framework/slsa-verifier/releases/download/v2.5.1/slsa-verifier-linux-amd64 .
RUN echo "54e4f40bf120bce1cef1ff123fef3456e8c526f315c47e22ed6acfe02a06b9a8 slsa-verifier-linux-amd64" | sha256sum -c --strict -

ADD https://github.com/ko-build/ko/releases/download/v${KO_RELEASE}/ko_${KO_RELEASE}_linux_x86_64.tar.gz ko.tar.gz
ADD https://github.com/ko-build/ko/releases/download/v${KO_RELEASE}/multiple.intoto.jsonl provenance.intoto.jsonl
RUN ./slsa-verifier-linux-amd64 verify-artifact ko.tar.gz \
    --provenance-path provenance.intoto.jsonl --source-uri github.com/ko-build/ko --source-tag v${KO_RELEASE}
RUN tar xf ko.tar.gz ko

FROM golang:$GO_RELEASE
COPY --from=fetcher /ko /usr/bin/ko
