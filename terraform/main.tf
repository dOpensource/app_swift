provider "digitalocean" {
    token = "${var.do_token}"
}


data "digitalocean_ssh_key" "ssh_key" {
  name = "jump"
}


resource "digitalocean_droplet" "asterisk" {
        name = "${var.asterisk-dropletname}${count.index}"
        count = "${var.number_of_environments}"
        region = "nyc1"
        size="1gb"
        image="debian-9-x64"
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
          "sudo mkdir -p ~/bits/kamailio",
          "sudo apt-get update; sudo apt-get install -y git sngrep gcc g++ pkg-config libxml2-dev libssl-dev libcurl4-openssl-dev libpcre3-dev flex bison default-libmysqlclient-dev make autoconf mariadb-server",
          "sleep 20",
          "cd ~/bits",
	  "git clone --depth 1 --no-single-branch https://github.com/kamailio/kamailio -b 5.3 kamailio",
	  "cd ~/;git clone ${var.training-repo}",
          "sleep 20",
          "sed -i 's/\"set background=dark/set background=dark/' /etc/vim/vimrc"
        ]

      }
}
