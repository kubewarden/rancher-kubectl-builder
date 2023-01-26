FROM scratch

ARG TARGETARCH # set by docker, arch from --platform, e.g: arm64
COPY ${TARGETARCH}/kubectl /bin/kubectl
COPY etc_passwd /etc/passwd
COPY etc_group /etc/group
USER kubectl
ENTRYPOINT ["/bin/kubectl"]
CMD ["help"]
