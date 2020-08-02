namespace 'brewfile' do
  desc 'install homebrew packages from Brewfile'
  task :install do
    require 'got_files/homebrew'

    brew = GotFiles::Homebrew.new
    brew.bundle_install
  end

  desc 'update Brewfile'
  task :update do
    require 'got_files/homebrew'

    brew = GotFiles::Homebrew.new
    brew.update_brewfile
  end
end

namespace 'install' do
  desc 'install and setup Homebrew'
  task :brew do
    require 'got_files/homebrew'

    brew = GotFiles::Homebrew.new
    brew.install
    brew.setup
  end
end
