# frozen_string_literal: true

namespace "setup" do
  desc "setup Tmux"
  task :tmux do
    require "got_files/tmux"

    tmux = GotFiles::Tmux.new
    tmux.setup
  end
end
