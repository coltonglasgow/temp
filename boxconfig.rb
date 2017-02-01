#DNS
 system('cat ~/chef-repo/dl-elk/files/default/ipinfo.txt | grep "DNS1=.*" >> ~/chef-repo/dl-elk/files/default/resolv.conf')
 system('cat ~/chef-repo/dl-elk/files/default/ipinfo.txt | grep "DNS2=.*" >> ~/chef-repo/dl-elk/files/default/resolv.conf')
       system('mv ~/chef-repo/dl-elk/files/default/resolv.conf /etc/resolv.conf')

#default gateway
 system('cat ~/chef-repo/dl-elk/files/default/ipinfo.txt | grep "DEFAULT=.*" >> ~/chef-repo/dl-elk/files/default/network')
       system('mv ~/chef-repo/dl-elk/files/default/network /etc/sysconfig/network')

#STATIC IP
 system('cat ~/chef-repo/dl-elk/files/default/ipinfo.txt | grep "IPADDR=.*" >> ~/chef-repo/dl-elk/files/default/ifcfg-enp0s3')
 system('cat ~/chef-repo/dl-elk/files/default/ipinfo.txt | grep "NETMASK=.*" >> ~/chef-repo/dl-elk/files/default/ifcfg-enp0s3')
       system('mv ~/chef-repo/dl-elk/files/default/ifcfg-enp0s3 /etc/sysconfig/network-scripts/ifcfg-enp0s3')

#user and root pw
 system('sudo echo "linuxpassword1" | passwd --stdin user')
 system('sudo echo "linuxpassword2" | passwd --stdin root')

#kibana user and pw
 system('htpasswd -b -c /etc/nginx/htpasswd.users username password')
