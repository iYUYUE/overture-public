FROM alpine:3.12
RUN apk update \
	&& apk add curl \
	&& mkdir -p /etc/overture \
	&& wget https://github.com/shawn1m/overture/releases/download/v1.7-rc3/overture-linux-amd64.zip \
	&& unzip -d /etc/overture overture-linux-amd64.zip \
	&& cd /etc/overture \
	&& curl https://raw.githubusercontent.com/soffchen/GeoIP2-CN/release/CN-ip-cidr.txt > china_ips.txt \
	&& curl https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf | sed -e 's/server=\/\(.*\)\/114\.114\.114\.114/\1/' > china_domains.txt
COPY config.json /etc/overture/config.json
COPY update-china-lists.sh /etc/periodic/daily/update-china-lists
RUN chmod +x /etc/periodic/daily/update-china-lists

CMD echo -e "\n127.0.0.10 ${FLY_REGION}" >> /etc/overture/hosts_sample && /etc/overture/overture-linux-amd64 -c /etc/overture/config.json
