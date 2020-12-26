#!/bin/bash
set -e

curl https://raw.githubusercontent.com/soffchen/GeoIP2-CN/release/CN-ip-cidr.txt > /tmp/china_ips.txt
mv /tmp/china_ips.txt /etc/overture/china_ips.txt
curl https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf | sed -e 's/server=\/\(.*\)\/114\.114\.114\.114/\1/' > /tmp/china_domains.txt
mv /tmp/china_domains.txt /etc/overture/china_domains.txt

curl http://127.0.0.1:8080/reload
