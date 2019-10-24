require 'got_files/base'

module GotFiles
  class Iterm < Base

    def install
      brew_cask_install_if_missing('iterm2', 'iTerm2')
    end

    def setup
      # Open the app so the preference files get initialized unless iTerm2 is already running
      unless ENV['TERM_PROGRAM'] == 'iTerm.app'
        system('open -g "/Applications/iTerm.app" && sleep 2 && killall iTerm2')
      end

      # Allow access to the clipboard
      system('defaults write com.googlecode.iterm2 "AllowClipboardAccess" -bool true')

      # Enable using Powerline Glyphs, so we don't need to install a Powerline font
      system('defaults write com.googlecode.iterm2 "Draw Powerline Glyphs" -bool true')

      # Disable warning when quitting
      system('defaults write com.googlecode.iterm2 PromptOnQuit -bool false')

      # Set font to Monaco 14
      plistbuddy('Set "New Bookmarks":0:"Normal Font" Monaco 14', 'com.googlecode.iTerm2.plist') 
      plistbuddy('Set "New Bookmarks":0:"Use Non-ASCII Font" 0', 'com.googlecode.iTerm2.plist')

      # Unlimited Scrollback
      plistbuddy('Set "New Bookmarks":0:"Unlimited Scrollback" true', 'com.googlecode.iTerm2.plist')

      # Reset the preferences cache
      system %(killall cfprefsd)

      if ENV['TERM_PROGRAM'] == 'iTerm.app'
        require 'io/console'                                                                                                       

        puts 'Press Enter to close iTerm2 for settings to take effect...'
        STDIN.getch                                                                                                              
        system %(killall iTerm2)
      end
    end
  end
end
