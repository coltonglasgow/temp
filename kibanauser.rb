
#change root and vagrant pw
print "\e[H\e[2J"
system('passwd root ')
print "\e[H\e[2J"
system('passwd vagrant')

#create kibana user and pw
print "\e[H\e[2J"
prompt = 'Please enter a username for the Kibana web interface:'
puts prompt
user_name = gets.chomp

system('htpasswd -c /etc/nginx/htpasswd.users ' + user_name)
