system('cp /etc/sysconfig/network-scripts/ifcfg-enp0s3 /etc/sysconfig/network-scripts/ifcfg-enp0s3BACK')

require 'tempfile'
 
        def file_edit(filename, regexp, replacement)
            Tempfile.open(".#{File.basename(filename)}", File.dirname(filename)) do |tempfile|
                File.open(filename).each do |line|
                tempfile.puts line .gsub(regexp, replacement)
            end
            tempfile.fdatasync
            tempfile.close
            stat = File.stat(filename)
            FileUtils.chown stat.uid, stat.gid, tempfile.path
            FileUtils.chmod stat.mode, tempfile.path
            FileUtils.mv tempfile.path, filename
            end
        end

        file_edit('/etc/sysconfig/network-scripts/ifcfg-enp0s3BACK', '', 'disabled')
