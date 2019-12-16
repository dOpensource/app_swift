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
          # install git repo and and server up the index page
          #"sudo mkdir -p ~/bits/test",
          "yum update -y ",
          "yum groupinstall –y Development Tools -y ",
          "sleep 20 ",
          "cd /usr/src/ ",
          "yum install -y wget ",
          "setenforce 0 ",
         # "sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/sysconfig/selinux ",
         # "sed -i 's/\(^SELINUX=\).*/\SELINUX=disabled/' /etc/selinux/config ",
          "getenforce ",
          "wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz ",
          "tar zxf asterisk-16-current.tar.gz ",
          "cd asterisk-16.6.2/ ",
          "contrib/scripts/get_mp3_source.sh ",
          "contrib/scripts/install_prereq install ",
          "sleep 10 ",
          "./configure --with-jansson-bundled ",
          "make menuselect.makeopts ",
          "make ",
          "make install ", 
          "make basic-pbx ",
          "make config ",
          "ldconfig ",
          "adduser --system --user-group --home-dir /var/lib/asterisk --no-create-home asterisk ",
          "usermod -a -G dialout,audio asterisk ",
          "make samples ",
          "systemctl start asterisk ",
          "sleep 10 ",
          "cd /usr/local/src/ ",
          "tar -zxvf Cepstral_Allison-8kHz_x86-64-linux_6.0.1.tar.gz ",
          "git clone https://github.com/dOpensource/app_swift.git "
         #(note: please install app swift and cepstral allison manually)
         # "rebbot"
        ]

      }
}
