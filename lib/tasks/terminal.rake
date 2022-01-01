# frozen_string_literal: true

namespace "install" do
  desc "install and setup terminal and shell experience"
  task :terminal do
    require "got_files/terminal"

    terminal = GotFiles::Terminal.new
    terminal.install
    terminal.setup
  end
end
