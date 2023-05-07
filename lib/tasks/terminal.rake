# frozen_string_literal: true

namespace "setup" do
  desc "setup terminal and shell experience"
  task :terminal do
    require "got_files/terminal"

    terminal = GotFiles::Terminal.new
    terminal.setup
  end
end
