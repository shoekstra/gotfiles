require 'got_files/base'

module GotFiles
  class Neovim < Base

    def install
      brew_install_if_missing('neovim', 'Neovim')

      system("pip3 install --upgrade pynvim --user", :out => File::NULL)
    end

    def setup
      mkdir_p File.expand_path("~/.config/nvim/backup")
      mkdir_p File.expand_path("~/.config/nvim/cache")
      mkdir_p File.expand_path("~/.config/nvim/undo")

      File.open(File.expand_path("~/.config/nvim/init.vim"), 'w') do |file|
        file.write(
          [
	    "\" Add all neovim configuration to the file sourced below, this file is not managed",
            "source ~/.nvimrc\n"
	  ].join("\n")
	)
      end

      install_file 'files/neovim/nvimrc'

      system("curl -s -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")

      system("nvim +PlugInstall +qall")
    end
  end
end
