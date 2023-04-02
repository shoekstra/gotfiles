# frozen_string_literal: true

require "got_files/base"

module GotFiles
  class Gpg < Base
    def setup(key)
      return unless key

      puts "Importing GPG key #{key}"
      system("gpg --import \"#{key}\"")
    end
  end
end
