require 'got_files/base'

module GotFiles
  class Terminal < Base

    def install
      brew_cask_install_if_missing('iterm2', 'iTerm2')

      brew_install_if_missing('rename', 'rename')

      brew_install_if_missing('fzf', 'fzf')
      system('$(brew --prefix)/opt/fzf/install --key-bindings --no-update-rc --no-bash --no-fish --completion', :out => File::NULL)

      # Git tools
      brew_install_if_missing('hub', 'hub')
      brew_install_if_missing('github/gh/gh', 'GitHub CLI')
      brew_install_if_missing('zaquestion/tap/lab', 'GitLab CLI')
    end

    def setup
      # Open the app so the preference files get initialized unless iTerm2 is already running
      unless ENV['TERM_PROGRAM'] == 'iTerm.app'
        system('open -g "/Applications/iTerm.app" && sleep 2 && killall iTerm2')
      end

      # Allow access to the clipboard
      system('defaults write com.googlecode.iterm2 "AllowClipboardAccess" -bool true')

      # Disable warning when quitting
      system('defaults write com.googlecode.iterm2 PromptOnQuit -bool false')

      # Unlimited Scrollback
      plistbuddy('Set "New Bookmarks":0:"Unlimited Scrollback" true', 'com.googlecode.iTerm2.plist')

      # Reset the preferences cache
      system %(killall cfprefsd)

      puts 'Restart iTerm2 using ⌘+Q to settings to take effect...'
    end
  end
end
