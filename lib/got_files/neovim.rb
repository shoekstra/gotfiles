# frozen_string_literal: true

require "got_files/base"

module GotFiles
  class Neovim < Base
    def install
      puts "Checking for dependencies..."

      brew_install_if_missing("cmake", "CMake")
      brew_install_if_missing("go", "Golang")
      brew_install_if_missing("python", "Python 3")

      brew_install_if_missing("neovim", "Neovim")

      system("pip3 install --upgrade pynvim --user", out: File::NULL)
      system("pip3 install --upgrade neovim --user", out: File::NULL)
    end

    def setup
      system('defaults write com.googlecode.iterm2 "Draw Powerline Glyphs" -bool true')

      mkdir_p File.expand_path("~/.config/nvim/backup")
      mkdir_p File.expand_path("~/.config/nvim/cache")
      mkdir_p File.expand_path("~/.config/nvim/undo")

      File.open(File.expand_path("~/.config/nvim/init.vim"), "w") do |file|
        file.write(
          [
            "\" Add all neovim configuration to the file sourced below, this file is not managed",
            "source ~/.nvimrc\n"
          ].join("\n")
        )
      end

      install_file "files/neovim/nvimrc"
    end
  end
end
