provider "digitalocean" {
    token = "${var.do_token}"
}


data "digitalocean_ssh_key" "ssh_key" {
  name = "dopensource-training"
}


resource "digitalocean_droplet" "asterisk" {
        name = "${var.asterisk-dropletname}${count.index}"
        count = "${var.number_of_environments}"
        region = "nyc1"
        size="1gb"
        image="centos-7-x64"
	      ssh_keys = [ "${data.digitalocean_ssh_key.ssh_key.fingerprint}" ]

        connection {
        user = "root"
        type = "ssh"
        private_key = "${file(var.pvt_key)}"
        timeout = "5m"
        }

        provisioner "remote-exec" {
          inline = [
          "export PATH=$PATH:/usr/bin",
          "yum groupinstall –y Development Tools -y ",
          "yum install –y ncurses-dev uuid-devel libuuid-devel libxml2-devel sqlite-devel bison subversion git-core -y ",
          "sleep 20",
          "cd /usr/src/ ",
          "yum install -y wget ",
           "wget http://www.digip.org/jansson/releases/jansson-2.7.tar.gz ",
           "tar -zxvf jansson-2.7.tar.gz ",
           "cd jansson-2.7 ",
           "./configure --prefix=/usr/  ",
           "make clean ",
           "make && make install ",
           "ldconfig ",
           "cd /usr/local/src/ ",
           "yum install -y libtermcap-devel",
           "sleep 10",
           "wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-13.29.1.tar.gz ",
           "tar -zxvf asterisk-13.29.1.tar.gz ",
           "cd asterisk-13.29.1 ",
           "sleep 20", 
           "./configure --libdir=/usr/lib64 ",
           "make menuselect.makeopts ",
           "contrib/scripts/get_mp3_source.sh",
           "make",
            "sleep 30",
           "make install",
           "sleep 30",
           "make samples",
           "sleep 30",  
           "make config",
           "useradd -m asterisk ",
           "chown asterisk.asterisk /var/run/asterisk ",           
           "chown -R asterisk.asterisk /etc/asterisk ",
           "chown -R asterisk.asterisk /var/{lib,log,spool}/asterisk ",
           "chown -R asterisk.asterisk /usr/lib64/asterisk ",
           "setenforce 0", 
           "systemctl restart asterisk ",
           "systemctl status asterisk ",
          #"sed -i 's/^\(SELINUX\)=enforcing/\1=disabled/' /etc/selinux/config ",
          #"asterisk -rvvv ",
          #"exit ",
           "cd /usr/local/src/ ",        
           "wget https://www.cepstral.com/downloads/installers/linux64/Cepstral_Allison-8kHz_x86-64-linux_6.0.1.tar.gz", 
           "sleep 10 ",
           "tar -zxvf Cepstral_Allison-8kHz_x86-64-linux_6.0.1.tar.gz ",
           "git clone https://github.com/dOpensource/app_swift.git"
        ]

      }
}
