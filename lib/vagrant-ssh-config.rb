require "vagrant-ssh-config/plugin"

module VagrantPlugins
  module SshConfig
    def self.source_root
      @source_root ||= Pathname.new(File.expand_path('../../', __FILE__))
    end
  end
end
