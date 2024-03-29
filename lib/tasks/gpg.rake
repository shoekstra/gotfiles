# frozen_string_literal: true

namespace "setup" do
  desc "import a key"
  task :gpg, [:key_to_import] do |_t, args|
    require "got_files/Gpg"

    gpg = GotFiles::Gpg.new
    gpg.setup(args[:key_to_import])
  end
end
