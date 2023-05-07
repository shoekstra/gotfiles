# frozen_string_literal: true

namespace "setup" do
  desc "setup Neovim"
  task :neovim do
    require "got_files/neovim"

    neovim = GotFiles::Neovim.new
    neovim.setup
  end
end
