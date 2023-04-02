# Got Files?

My dot-files.

I use [Rake](https://ruby.github.io/rake/) to manage my dot-files. It uses [Homebrew](https://brew.sh/) to install packages and Ruby to install dot-files and/or perform any extra customisations.

I'm in the process of moving to a [nix-based setup](https://nixos.org/explore.html) -- using [nix-darwin](https://github.com/LnL7/nix-darwin) and [Home Manager](https://github.com/nix-community/home-manager) -- to replace this home-grown solution.

If this setup is new to you, these resources helped me:

* [Home Manager Manual](https://nix-community.github.io/home-manager/)
* [Migrating from Homebrew to Nix for OSX](https://discourse.nixos.org/t/migrating-from-homebrew-to-nix-for-osx/2892)
* [Declarative macOS Configuration Using nix-darwin And home-manager](https://xyno.space/post/nix-darwin-introduction)
* [Setup nix, nix-darwin and home-manager from scratch on an M1 Macbook Pro](https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050)
* [How to Learn Nix, Part 19 Switching from Homebrew to Nix](https://ianthehenry.com/posts/how-to-learn-nix/switching-from-homebrew-to-nix/)

I probably should've learned how to use Nix the current way, but instead I've started using the [experimental Flake method](https://nixos.wiki/wiki/Flakes). This will no doubt get some major rewrites as I learn how nix, flakes and the different modules work together.

## Installation

Install Xcode developer tools:

```shell
xcode-select --install
```

Clone this repo:

```shell
git clone https://github.com/shoekstra/gotfiles.git ~/git/gotfiles
cd ~/git/gotfiles
```

Setup Home Manager before running `rake install`.

### Home Manager

```shell
make install
```

### Ruby

Install required gems:

```shell
bundle install --path vendor/bundle
```

View options:

```shell
bundle exec rake -T
```

Install everything:

```shell
bundle exec rake install
```

Set iTerm2 to use Natural Text Editing:

1. Open Preferences
1. Click "Profile" tab
1. Select a profile in the list on the left (eg "Default") and click "Keys" tab
1. Click the "Presets" downdown and select "Natural Text Editing"

[Install One Half iTerm2 theme](https://github.com/sonph/onehalf#iterm2).

Install iTerm2 theme:
1. Download iTerm2 One Half Dark preset: `wget -O /tmp/OneHalfDark.itermcolors https://raw.githubusercontent.com/sonph/onehalf/master/iterm/OneHalfDark.itermcolors`
1. Install preset: `open /tmp/OneHalfDark.itermcolors`
1. In iTerm: Preferences > Profiles > Colors, choose OneHalfDark
