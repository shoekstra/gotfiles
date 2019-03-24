require 'got_files/base'

module GotFiles
  class Zsh < Base
    def install
      brew_install_if_missing('coreutils') # required gdircolors and gls
      brew_install_if_missing('zsh', 'Zsh')

      unless File.exist?("#{ENV['HOME']}/.zim")
        system("curl -fsSL https://raw.githubusercontent.com/zimfw/install/develop/install.zsh | zsh", :out => File::NULL)
        %w(zimrc zshrc zlogin).each do |zfile|
          FileUtils.rm_f("#{ENV['HOME']}/.#{zfile}")
        end
      end
    end

    def setup
      add_shell
      set_shell

      install_file Dir.glob('files/zsh/*')

      unless ENV['SHELL'].include?('zsh')
        puts 'Open a new terminal and run this task again to complete ZSH setup ...'

        return
      end

      zimfw_install
    end

    private

    def add_shell
      shells = File.readlines('/private/etc/shells')
      return if shells.grep(%r{/usr/local/bin/zsh}).any?

      puts 'Adding zsh to standard shell list ...'
      run %(echo '/usr/local/bin/zsh' | sudo tee -a /private/etc/shells)
    end

    def set_shell
      return if ENV['SHELL'].include?('zsh')

      puts 'Setting zsh as your default shell ...'
      run %(chsh -s /usr/local/bin/zsh)
    end

    def zimfw_install
      run %(zsh -ic 'zimfw install') # Install new modules
      run %(zsh -ic 'zimfw update')  # Update existing modules
    end
  end
end
