namespace 'install' do
  desc 'install and setup iTerm2'
  task :iterm2 do
    require 'got_files/iterm'
  
    iterm = GotFiles::Iterm.new
    iterm.install
    iterm.setup
  end
end
