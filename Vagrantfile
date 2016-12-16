$java = <<SCRIPT
  sudo add-apt-repository ppa:webupd8team/java
  sudo apt-get update
  sudo /bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
  sudo /bin/echo /usr/bin/debconf shared/accepted-oracle-license-v1-1 seen true  | /usr/bin/debconf-set-selections
  sudo apt-get install -y oracle-java8-installer
SCRIPT

$sysctl = <<SCRIPT
sudo sysctl -w vm.max_map_count=262144
sudo echo 'vm.max_map_count=262144' >> /etc/sysctl.conf
SCRIPT

$python = <<SCRIPT
sudo apt-get install -y python python3 python-pip python3-pip
pip install elasticsearch
pip3 install elasticsearch
SCRIPT

$es_deploy = <<SCRIPT
sudo apt-get install -y unzip
sudo cp /vagrant/materials/AdvancedElasticsearchDataModeling-v5.0.2.zip /opt/es.zip
cd /opt && sudo unzip es.zip && sudo chown -R ubuntu /opt/AdvData/
SCRIPT

boxes = [
  {
    :name => "es-1",
    :mem  => "8192",
    :cpu  => "4",
    :ip   => "192.168.56.201"
  },
  #{
  #  :name => "es-2",
  #  :mem  => "2048",
  #  :cpu  => "2",
  #  :ip   => "192.168.56.202"
  #},
  #{
  #  :name => "es-3",
  #  :mem  => "2048",
  #  :cpu  => "2",
  #  :ip   => "192.168.56.203"
  #},
]

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"

  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.hostname = opts[:name]
      config.vm.network 'private_network', ip: opts[:ip]

      config.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--memory", opts[:mem]]
        v.customize ["modifyvm", :id, "--cpus", opts[:cpu]]
      end
      config.vm.provision "shell", inline: $java
      config.vm.provision "shell", inline: $sysctl
      config.vm.provision "shell", inline: $python
      config.vm.provision "shell", inline: $es_deploy
    end
  end
end
