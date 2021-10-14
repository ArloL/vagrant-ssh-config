require "vagrant-ssh-config/Action/UpdateConfig"

module VagrantPlugins
    module SshConfig
        class Plugin < Vagrant.plugin('2')

            name 'SshConfig'

            description <<-DESC
                This plugin does stuff.
            DESC

            action_hook(:ssh, :machine_action_up) do |hook|
                hook.after(Vagrant::Action::Builtin::WaitForCommunicator, Action::UpdateConfig)
            end

            action_hook(:ssh, :machine_action_reload) do |hook|
                hook.after(Vagrant::Action::Builtin::WaitForCommunicator, Action::UpdateConfig)
            end

            action_hook(:ssh, :machine_action_resume) do |hook|
                hook.after(Vagrant::Action::Builtin::WaitForCommunicator, Action::UpdateConfig)
            end

        end
    end
end
