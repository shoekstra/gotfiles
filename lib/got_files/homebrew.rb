# frozen_string_literal: true

require "got_files/base"

module GotFiles
  class Homebrew < Base
    def install
      return if installed?

      system('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"')
    end

    def installed?
      command_exist?("brew")
    end
  end
end
