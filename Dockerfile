FROM scratch

ARG TARGETARCH # set by docker, arch from --platform, e.g: arm64
COPY --chmod=0755 ${TARGETARCH}/kubectl /bin/kubectl
COPY etc_passwd /etc/passwd
COPY etc_group /etc/group
USER 65533:65533
ENTRYPOINT ["/bin/kubectl"]
CMD ["help"]
