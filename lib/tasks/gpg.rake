namespace 'install' do
  desc 'install and setup GPG Agent (and optionally import an exported key)'
  task :gpg, [:key_to_import] do |t, args|
    require 'got_files/Gpg'
  
    gpg = GotFiles::Gpg.new
    gpg.install
    gpg.setup(args[:key_to_import])
  end
end
