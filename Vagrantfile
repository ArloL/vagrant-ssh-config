# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/focal64"

  config.vm.provider "virtualbox" do |vb|
    vb.linked_clone = true
  end

  config.trigger.after :up, :reload, :resume do |trigger|
    trigger.ruby do |env,machine|
      config = `vagrant ssh-config #{machine.name} --host #{ENV["VAGRANT_SSH_ALIAS"]}`
      File.write("#{env.local_data_path}/ssh-config", config)
      line = "Include #{env.local_data_path}/ssh-config"
      file = "#{env.home_path}/ssh-configs"
      if File.exist?(file)
        if ! File.foreach(file).grep(/#{line}/).any?
          File.open(file, "a+") { |f| f.puts(line) }
        end
      else
        File.write(file, line)
      end
    end
  end

  config.vm.network "forwarded_port", guest: 62225, host: 62225

  config.vm.provision "docker" do |d|
    d.post_install_provision "shell", inline: $dockerOpenTcpPortScript
  end

end

$dockerOpenTcpPortScript = <<-'SCRIPT'
set -o errexit
set -o nounset
set -o xtrace

mkdir -p /etc/systemd/system/docker.service.d
echo '[Service]' > /etc/systemd/system/docker.service.d/override.conf
echo 'ExecStart=' >> /etc/systemd/system/docker.service.d/override.conf
echo 'ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:62225 --containerd=/run/containerd/containerd.sock' >> /etc/systemd/system/docker.service.d/override.conf
systemctl daemon-reload
systemctl stop docker.service
systemctl start docker.service
SCRIPT
