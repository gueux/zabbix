# -*- mode: ruby -*-
# vi: set ft=ruby :

# This Vagrantfile needs the vagrant-omnbius plugin installed
# To install this, run "vagrant plugin install vagrant-omnibus"

Vagrant.configure("2") do |config|
  config.vm.provider :virtualbox do |vbox|
    vbox.customize ['modifyvm', :id,
                    '--memory', 1024]
  end

  config.vm.box = "chef/ubuntu-14.04"
  #config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box"

  config.vm.hostname = "zabbix-berkshelf"
  server_ip = "192.168.50.10"
  config.vm.network :private_network, ip: server_ip
  config.ssh.insert_key = false

  config.trigger.before :reload, stdout: true do
    puts "Remove 'synced_folders' file for #{@machine.name}"
    `rm .vagrant/machines/#{@machine.name}/virtualbox/synced_folders`
  end

  config.omnibus.chef_version = :latest
  config.vm.provision :chef_zero do |chef|
    chef.nodes_path = 'fixtures/nodes'
    chef.json = {
      "th_mysql" => {
        "service" => {
          "data_dir" => "/var/lib/mysql-default",
          "server_root_password" => "GlagDyn0"
        },
        "users" => {
          "zabbix" => {
            "password" => "password123",
            "database_name" => "zabbix"
          }
        }
      },
      'zabbix' => {
        'server' => {
          'version' => '2.4.0'
        },
        'proxy' => {
          'enabled' => true,
          'master' => 'mail.randrmusic.com',
          'database' => {
            'dbport' => '3306',
            'dbname' => 'zabbix',
            'dbuser' => 'zabbix',
            'dbpassword' => 'password123'
          }
        },
        'database' => {
          'install_method' => 'mysql',
          'schema_only' => true,
          'dbport' => '3306',
          'dbname' => 'zabbix',
          'dbuser' => 'zabbix',
          'dbpassword' => 'password123'
        },
        'web' => {
          'fqdn' => 'zabbix.vocvox.com',
          'user' => 'Admin',
          'password' => 'p45gh548GL4h'
      }
      }
    }

    chef.add_recipe "th_mysql"
    chef.add_recipe "zabbix"
    chef.add_recipe "zabbix::database"
    chef.add_recipe "zabbix::proxy_source"

    #chef.log_level = :debug
  end
end
