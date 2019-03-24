namespace 'install' do
  desc 'install and setup Zsh and Zim'
  task :zsh do
    require 'got_files/zsh'
  
    zim = GotFiles::Zsh.new
    zim.install
    zim.setup
  end
end
