require 'got_files/base'

module GotFiles
  class Tmux < Base

    def install
      brew_install_if_missing('reattach-to-user-namespace')
      brew_install_if_missing('tmux', 'Tmux')

      git('https://github.com/gpakosz/.tmux.git',
	      "#{ENV['HOME']}/.tmux",
	      'Oh My Tmux!'
      )

      git('https://github.com/tmux-plugins/tpm',
	      "#{ENV['HOME']}/.tmux/plugins/tpm",
	      'Tmux Plugin Manager'
      )
    end

    def setup
      install_file %w(~/.tmux/.tmux.conf files/tmux/tmux.conf.local)

      if ENV['TMUX']
        run %(tmux source ~/.tmux.conf)
      end
    end
  end
end
