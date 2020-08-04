# Got Files?

My dot-files.

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

Install required gems:

```shell
bundle install --path vendor/bundle
```

## Usage

View options:

```shell
bundle exec rake -T
```

Install everything:

```shell
bundle exec rake install
```
