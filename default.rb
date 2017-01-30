#
# Cookbook::elk
# Recipe::default
#
# Copyright:: 2017, Champion Technology Company, All Rights Reserved.
#

puts "\e[H\e[2J"

execute 'stop packagekitd (yum lock)' do
 action :run
 command 'systemctl stop packagekit.service'
end

#yum update
execute 'yum update' do
 action :run
 command 'yum update -y'
end

#xterm for popout terminals
execute 'xterm' do
 action :run
 command 'yum install xterm -y'
end

#basic tools
package 'ruby'
package 'wget'
package 'net-tools'
package 'nano'


#java
execute 'java get' do
 action :run
 command 'sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.rpm"'
end
execute 'java install' do
 action :run
 command 'sudo yum localinstall jdk-8u112-linux-x64.rpm -y'
end
execute 'rm old jkd*' do
 action :run
 command 'sudo rm /jdk-8u112-linux-x64.rpm*'
end

#elasticsearch
execute 'import elasticsearch' do
 action :run
 command 'sudo rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch'
end

yum_repository "elasticsearch" do
    description 'Elasticsearch repository for 5.x packages'
    baseurl 'https://artifacts.elastic.co/packages/5.x/yum'
    gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
    action :create
end

yum_package 'elasticsearch' do
end


#kibana
yum_repository "kibana" do
    description 'Kibana repository for 5.x packages'
    baseurl 'https://artifacts.elastic.co/packages/5.x/yum'
    gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
    action :create
end

package 'kibana'


#epel-release
package 'epel-release'


#Nginx
package 'nginx'


#nginx.conf edit
execute 'nginx.conf edit' do
 action :run
 command 'cp /etc/chef/nginx.conf /etc/nginx/nginx.conf'
end


#httpd-tools
package 'httpd-tools'


#http password
#execute 'configure kibana htaccess' do
 #action :run
 #command 'xterm -e ruby /etc/chef/kibanauser.rb'
#end


#logstash
yum_repository "logstash" do
    description 'Elastic repository for 5.x packages'
    baseurl 'https://artifacts.elastic.co/packages/5.x/yum'
    gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
    action :create
end

package 'logstash'


    #plugins
execute 'logstash-output-stomp plugin' do
 action :run
 command 'sudo /usr/share/logstash/bin/logstash-plugin install logstash-output-stomp'
end
execute 'logstash-filter-tld plugin' do
 action :run
 command 'sudo /usr/share/logstash/bin/logstash-plugin install logstash-filter-tld'
end
execute 'plugin update' do
 action :run
 command 'sudo /usr/share/logstash/bin/logstash-plugin update'
end


#geoip
directory '/var/local/geoip' do
 action :create
end
    #update
system('/etc/logstash/geo-update.bash > /dev/null 2>&1')


#disable selinux
execute 'nginx.conf edit' do
 action :run
 command 'cp /nginx.conf /etc/nginx/nginx.conf'
end

#disable firewall
execute 'stop firewalld' do
 action :run
 command 'systemctl stop firewalld'
end
execute 'disable firewalld' do
 action :run
 command 'systemctl disable firewalld'
end

#http_port_t 5601
system('semanage port -a -t http_port_t -p tcp 5601')

#activemq
execute 'makes activemq.sh executable' do
 action :run
 command 'chmod +x /etc/chef/activemq.sh'
end
execute 'installs activemq' do
 action :run
 command './etc/chef/activemq.sh'
end


#start services (elasticsearch, logstash, kibana, and nginx) on startup
execute 'reload services' do
 action :run
 command '/bin/systemctl daemon-reload'
end
execute 'enable elastic search service' do
 action :run
 command '/bin/systemctl enable elasticsearch.service'
end
execute 'enable kibana search service' do
 action :run
 command '/bin/systemctl enable kibana.service'
end
execute 'enable logstash search service' do
 action :run
 command '/bin/systemctl enable logstash.service'
end
execute 'enable nginx search service' do
 action :run
 command '/bin/systemctl enable nginx.service'
end

#CRON JOB
#geoip update
cron 'geoip update' do
    minute '0'
    hour '12'
    day '*'
    month '*'
    weekday '3'
    command '/etc/logstash/geo-update.bash > /dev/null 2>&1'
end


#start service
execute 'start packagekitd (was stopped)' do
 action :run
 command 'systemctl start packagekit.service'
end
