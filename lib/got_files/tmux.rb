# frozen_string_literal: true

require "got_files/base"

module GotFiles
  class Tmux < Base
    def setup
      git("https://github.com/gpakosz/.tmux.git",
          "#{ENV['HOME']}/.tmux",
          "Oh My Tmux!")

      git("https://github.com/tmux-plugins/tpm",
          "#{ENV['HOME']}/.tmux/plugins/tpm",
          "Tmux Plugin Manager")

      install_file %w[~/.tmux/.tmux.conf files/tmux/tmux.conf.local]

      run %(tmux source ~/.tmux.conf) if ENV["TMUX"]
    end
  end
end
