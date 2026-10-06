require "open3"

module VagrantPlugins
  module SshConfig
    module Action
      class UpdateConfig

        def initialize(app, env)
          @app = app
          @env = env
        end

        def call(env)
          @app.call(env)
          @env[:ui].info "[vagrant-ssh-config] Updating SSH config..."
          # Pass arguments as a list so the machine name and alias never go
          # through a shell.
          command = ["vagrant", "ssh-config", @env[:machine].name.to_s]
          ssh_alias = ENV["VAGRANT_SSH_ALIAS"]
          command += ["--host", ssh_alias] unless ssh_alias.to_s.empty?
          config, _status = Open3.capture2(*command)
          File.write("#{@env[:env].local_data_path}/ssh-config", config)
          line = "Include #{@env[:env].local_data_path}/ssh-config"
          file = "#{@env[:env].home_path}/ssh-configs"
          if File.exist?(file)
            if File.foreach(file).none? { |l| l.chomp == line }
              File.open(file, "a+") { |f| f.puts(line) }
            end
          else
            File.write(file, line)
          end
        end

      end
    end
  end
end
