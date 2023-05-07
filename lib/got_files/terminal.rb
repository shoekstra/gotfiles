# frozen_string_literal: true

require "got_files/base"

module GotFiles
  class Terminal < Base
    def setup
      setup_fzf
      setup_zim

      # Use gnu dircolors and ls
      %w[dircolors ls].each do |f|
        symlink("/usr/local/bin/g#{f}",
                "/usr/local/bin/#{f}",
                force: true)
      end

      # Open the app so the preference files get initialized unless iTerm2 is already running
      system('open -g "/Applications/iTerm.app" && sleep 2 && killall iTerm2') unless ENV["TERM_PROGRAM"] == "iTerm.app"

      # Allow access to the clipboard
      system('defaults write com.googlecode.iterm2 "AllowClipboardAccess" -bool true')

      # Disable warning when quitting
      system("defaults write com.googlecode.iterm2 PromptOnQuit -bool false")

      # Unlimited Scrollback
      plistbuddy('Set "New Bookmarks":0:"Unlimited Scrollback" true', "com.googlecode.iTerm2.plist")

      # Reset the preferences cache
      system %(killall cfprefsd)

      puts "Restart iTerm2 using ⌘+Q to settings to take effect..."
    end

    private

    def setup_fzf
      system("$(brew --prefix)/opt/fzf/install --key-bindings --no-update-rc --no-bash --no-fish --completion",
             out: File::NULL)
    end

    def setup_zim
      unless File.exist?(File.join(ENV["HOME"], ".zim"))
        system("curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh")
      end

      install_file Dir.glob("files/zsh/*")

      system("zsh ~/.zim/zimfw.zsh install")
    end
  end
end
