# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'berkshelf/vagrant'

Vagrant.configure('2') do |config|
  config.vm.hostname = 'mariadb-vm'
  config.vm.box = 'archlinux'
  config.vm.box_url = '../../veewee/archlinux.box'

  config.ssh.default.username = 'gibson'
  config.ssh.max_tries = 40
  config.ssh.timeout   = 120
  config.ssh.private_key_path = '~/keys/gibson-id_rsa'

  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mariadb  => {
      }
    }

    chef.run_list = [
      'recipe[archlinux]',
      'recipe[mariadb::default]'
    ]
  end
end
