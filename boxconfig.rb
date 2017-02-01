#DNS
 system('cat /etc/dl/dl-elk/files/default/ipinfo.txt | grep "DNS1=.*" >> /etc/dl/dl-elk/files/default/')
 system('cat /etc/dl/dl-elk/files/default/ipinfo.txt | grep "DNS2=.*" >> /etc/dl/dl-elk/files/default/')
       system('mv ~/chef-repo/dl-elk/files/default/resolv.conf /etc/resolv.conf')

#default gateway
 system('cat /etc/dl/dl-elk/files/default/ipinfo.txt | grep "DEFAULT=.*" >> /etc/dl/dl-elk/files/default/network')
       system('mv ~/chef-repo/dl-elk/files/default/network /etc/sysconfig/network')

#STATIC IP
 system('cat /etc/dl/dl-elk/files/default/ipinfo.txt | grep "IPADDR=.*" >> /etc/dl/dl-elk/files/default/ifcfg-enp0s3')
 system('cat /etc/dl/dl-elk/files/default/ipinfo.txt | grep "NETMASK=.*" >> /etc/dl/dl-elk/files/default/ifcfg-enp0s3')
       system('mv ~/chef-repo/dl-elk/files/default/ifcfg-enp0s3 /etc/sysconfig/network-scripts/ifcfg-enp0s3')

#user and root pw
 system('sudo echo "linuxpassword1" | passwd --stdin user')
 system('sudo echo "linuxpassword2" | passwd --stdin root')

#kibana user and pw
 system('htpasswd -b -c /etc/nginx/htpasswd.users username password')
