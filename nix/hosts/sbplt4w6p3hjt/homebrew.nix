{
  homebrew.enable = true;

  homebrew.taps = [
    "homebrew/services"
  ];

  homebrew.brews = [
    "danielfoehrkn/switch/switch"
    "go"
    "goreleaser"
    "qemu"  # For some reason minikube wants this installed via homebrew
    "socket_vmnet"
    "vcluster"
    "yleisradio/terraforms/chtf"
  ];

  homebrew.casks = [
    "docker"
    "iterm2"
    "maccy" # clipboard manager https://maccy.app
    "microsoft-remote-desktop"
    "postman"
    "skitch"
    "spotify"
    "telegram"
    "visual-studio-code"
    "whatsapp"
  ];
}
