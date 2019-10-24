namespace 'install' do
  desc 'install and setup Homebrew'
  task :brew do
    require 'got_files/homebrew'
  
    brew = GotFiles::Homebrew.new
    brew.install
    brew.setup
    brew.bundle_install
  end
end

namespace 'update' do
  desc 'update Brewfile'
  task :brewfile do
    require 'got_files/homebrew'
  
    brew = GotFiles::Homebrew.new
    brew.update_brewfile
  end
end
