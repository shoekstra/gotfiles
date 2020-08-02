require 'got_files/base'

module GotFiles
  class Homebrew < Base

    def bundle_install
      Dir.chdir(File.expand_path("~")) do
        system('brew bundle')
      end
    end

    def install
      return if installed?

      system('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"')
    end

    def installed?
      command_exist?('brew')
    end

    def update_brewfile
      Dir.chdir(File.expand_path("~")) do
        system('brew bundle dump --force')
      end
    end

    def setup
      install_file 'files/homebrew/Brewfile', false
    end
  end
end
