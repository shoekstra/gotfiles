namespace 'install' do
  desc 'install and setup Tmux'
  task :tmux do
    require 'got_files/tmux'
  
    tmux = GotFiles::Tmux.new
    tmux.install
    tmux.setup
  end
end
