require 'got_files/base'

module GotFiles
  class Terminal < Base

    def install
      brew_cask_install_if_missing('iterm2', 'iTerm2')

      brew_install_if_missing('coreutils') # required gdircolors and gls
      brew_install_if_missing('ccat', 'ccat')
      brew_install_if_missing('rename', 'rename')

      # Git tools
      brew_install_if_missing('hub', 'hub')
      brew_install_if_missing('github/gh/gh', 'GitHub CLI')
      brew_install_if_missing('zaquestion/tap/lab', 'GitLab CLI')

      install_fzf
      install_zim
    end

    def setup
      # Use gnu dircolors and ls
      %w(dircolors ls).each do |f|
        symlink("/usr/local/bin/g#{f}",
                "/usr/local/bin/#{f}",
                force: true)
      end

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

    private

    def install_fzf
      brew_install_if_missing('fzf', 'fzf')

      system('$(brew --prefix)/opt/fzf/install --key-bindings --no-update-rc --no-bash --no-fish --completion', :out => File::NULL)
    end

    def install_zim
      unless File.exists?(File.join(ENV['HOME'], '.zim'))
        system('curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | zsh')
      end

      install_file Dir.glob('files/zsh/*')

      system('zsh ~/.zim/zimfw.zsh install')
    end
  end
end
