FROM alpine:3.8

RUN apk --no-cache --no-progress update \
	&& apk --no-cache --no-progress upgrade \
	&& apk --no-cache --no-progress add tini \
	&& apk --no-cache --no-progress add openvpn \
	&& apk --no-cache --no-progress add curl

HEALTHCHECK --interval=30m --timeout=5s --retries=2 CMD curl -L 'https://api.ipify.org' || exit 1

VOLUME ["/vpn"]

ENTRYPOINT ["/sbin/tini", "--", "/vpn/openvpn.sh"]
