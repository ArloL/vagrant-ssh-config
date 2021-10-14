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
          config = `vagrant ssh-config #{@env[:machine].name} --host #{ENV["VAGRANT_SSH_ALIAS"]}`
          File.write("#{@env[:env].local_data_path}/ssh-config", config)
          line = "Include #{@env[:env].local_data_path}/ssh-config"
          file = "#{@env[:env].home_path}/ssh-configs"
          if File.exist?(file)
            if ! File.foreach(file).grep(/#{line}/).any?
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
