# frozen_string_literal: true

namespace "install" do
  desc "install and setup GPG Agent (and optionally import an exported key)"
  task :gpg, [:key_to_import] do |_t, args|
    require "got_files/Gpg"

    gpg = GotFiles::Gpg.new
    gpg.setup(args[:key_to_import])
  end
end
