# frozen_string_literal: true

require_relative "lib/vagrant-ssh-config/version"

Gem::Specification.new do |spec|
  spec.name          = "vagrant-ssh-config"
  spec.version       = VagrantPlugins::SshConfig::VERSION
  spec.authors       = ["Arlo O'Keeffe"]
  spec.email         = ["tiger@k5d.de"]

  spec.summary       = %q{Enables Vagrant to write a global ssh config}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/ArloL/vagrant-ssh-config"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rake'
end
