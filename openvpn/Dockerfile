FROM alpine:3.8

RUN apk --no-cache --no-progress update \
	&& apk --no-cache --no-progress upgrade \
	&& apk --no-cache --no-progress add tini \
	&& apk --no-cache --no-progress add openvpn \
	&& apk --no-cache --no-progress add curl

VOLUME ["/vpn"]

ENTRYPOINT ["/sbin/tini", "--", "/vpn/openvpn.sh"]
