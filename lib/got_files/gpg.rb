# frozen_string_literal: true

require "got_files/base"

module GotFiles
  class Gpg < Base
    def install
      brew_install_if_missing("gnupg", "GnuPG")
      brew_install_if_missing("pinentry-mac", "pinentry-mac")
    end

    def setup(key)
      return unless key

      puts "Importing GPG key #{key}"
      system("gpg --import \"#{key}\"")
    end
  end
end
