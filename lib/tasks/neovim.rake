namespace 'install' do
  desc 'install and setup Neovim'
  task :neovim do
    require 'got_files/neovim'
  
    neovim = GotFiles::Neovim.new
    neovim.install
    neovim.setup
  end
end
