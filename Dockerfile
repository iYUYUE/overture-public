FROM alpine:3.12
RUN apk update \
	&& apk add curl \
	&& mkdir -p /etc/overture \
	&& wget https://github.com/shawn1m/overture/releases/download/v1.7-rc3/overture-linux-amd64.zip \
	&& unzip -d /etc/overture overture-linux-amd64.zip \
	&& cd /etc/overture \
	&& wget https://raw.githubusercontent.com/iYUYUE/overture-public/main/config.json -O config.json \
	&& curl https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf | sed -e 's/server=\/\(.*\)\/114\.114\.114\.114/\1/' > /etc/overture/china_domains.txt
	
CMD /etc/overture/overture-linux-amd64 -c /etc/overture/config.json
