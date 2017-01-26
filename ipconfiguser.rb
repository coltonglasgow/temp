#PROMPTS
prompt1 = 'Is this info correct? [y/n]'
prompt2 = 'Incorrect. Please enter y or n.'
prompt3 = 'Is this new info correct? [y/n]'

#CONTEXT OF FILE
puts "\e[H\e[2J"
puts File.read('/etc/dl/dl-elk/files/default/ipinfo.txt')

#VERIFICATION
	puts''
	puts prompt1
while ans = gets.chomp
case ans

when 'y'
	break
when 'n'
	puts "\e[H\e[2J"
	system('sudo nano /etc/dl/dl-elk/files/default/ipinfo.txt')
	puts ''
	puts File.read('/etc/dl/dl-elk/files/default/ipinfo.txt')
	puts prompt3
else
	puts "\e[H\e[2J"
	puts ''
	puts prompt2
	puts prompt1	
end
end

#DNS
 system('cat ipinfo.txt  | grep "DNS1=.*" >> /etc/dl/dl-elk/files/default/')
 system('cat ipinfo.txt  | grep "DNS2=.*" >> /etc/dl/dl-elk/files/default/')

#default gateway
 system('cat ipinfo.txt  | grep "DEFAULT=.*" >> /etc/dl/dl-elk/files/default/resolv.conf')

#STATIC IP
 system('cat ipinfo.txt  | grep "IPADDR=.*" >> /etc/dl/dl-elk/files/default/ifcfg-enp0s3')
 system('cat ipinfo.txt  | grep "NETMASK=.*" >> /etc/dl/dl-elk/files/default/ifcfg-enp0s3')

#CHANGES
	puts ''
	puts '----IP----'
	puts ''
puts IO.read("/etc/sysconfig/network-scripts/ifcfg-enp0s3")
	puts ''
	puts '----GATEWAY----'
	puts ''
puts IO.read("/etc/sysconfig/network")
	puts ''
	puts '----DNS----'
	puts ''
puts IO.read("/etc/resolv.conf")

#CLARIFICATION
puts ''
puts 'Is this information correct? [y/n]'
while ans2 = gets.chomp
case ans2
when 'y'
	puts "\e[H\e[2J"
	5.times do |i|
	print "Restarting Network Device." + ("." * (i % 3)) + " \r"
	$stdout.flush
	sleep(0.5)
end
system('systemctl restart network.service')
system('ifconfig enp0s3 down')
system('ifconfig enp0s3 up')

when 'n'
	puts "\e[H\e[2J"
	system('ruby /etc/dl/dl-elk/files/default/ipconfiguser.rb')
else
	puts "\e[H\e[2J"
	puts ''
	puts 'Please enter y or n.'	
end
end
