require 'got_files/base'

module GotFiles
  class Zsh < Base
    def install
      brew_install_if_missing('coreutils') # required gdircolors and gls

      %w(dircolors ls).each do |f|
        symlink("/usr/local/bin/g#{f}",
                "/usr/local/bin/#{f}",
                force: true)
      end

      system('curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh')

      install_file Dir.glob('files/zsh/*')

      system('zsh ~/.zim/zimfw.zsh install')
    end

    def setup
      add_shell
      set_shell
      install_fzf

      unless ENV['SHELL'].include?('zsh')
        puts 'Open a new terminal and run this task again to complete ZSH setup...'

        return
      end
    end

    private

    def add_shell
      shells = File.readlines('/private/etc/shells')
      return if shells.grep(%r{/usr/local/bin/zsh}).any?

      puts 'Adding zsh to standard shell list...'
      run %(echo '/usr/local/bin/zsh' | sudo tee -a /private/etc/shells)
    end

    def install_fzf
      return if File.exist? File.expand_path('~/.fzf')

      brew_install_if_missing('fzf')
      run %($(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc)
    end

    def set_shell
      return if ENV['SHELL'].include?('zsh')

      puts 'Setting zsh as your default shell...'
      run %(chsh -s /usr/local/bin/zsh)
    end
  end
end
