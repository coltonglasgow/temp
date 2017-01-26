#DNS
 system('cat /etc/dl/dl-elk/files/default/ipinfo.txt | grep "DNS1=.*" >> /etc/dl/dl-elk/files/default/')
 system('cat /etc/dl/dl-elk/files/default/ipinfo.txt | grep "DNS2=.*" >> /etc/dl/dl-elk/files/default/')

#default gateway
 system('cat /etc/dl/dl-elk/files/default/ipinfo.txt | grep "DEFAULT=.*" >> /etc/dl/dl-elk/files/default/resolv.conf')

#STATIC IP
 system('cat /etc/dl/dl-elk/files/default/ipinfo.txt | grep "IPADDR=.*" >> /etc/dl/dl-elk/files/default/ifcfg-enp0s3')
 system('cat /etc/dl/dl-elk/files/default/ipinfo.txt | grep "NETMASK=.*" >> /etc/dl/dl-elk/files/default/ifcfg-enp0s3')

