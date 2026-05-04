class TorchCmd < Formula
  desc "mkdir + touch command"
  homepage "https://github.com/toshimaru/torch"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.2/torch-cmd-aarch64-apple-darwin.tar.xz"
      sha256 "6794b41a30676b6055084a0f245405c85ab42326129fb70ee15809cae58f80d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.2/torch-cmd-x86_64-apple-darwin.tar.xz"
      sha256 "2bdc4fe261aba815ddf4c537ee3e36d25a2c4ae08759245beeea39352476dbc1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.2/torch-cmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "def205afdc9251cfb5fae2299abb827ed7222ce31e9703acfdf71cbb17466f68"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.2/torch-cmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6495ef51a0ca92affc8bebe6c1c2333d29b020ce4a272de6f828cebcf5ff8225"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "torch" if OS.mac? && Hardware::CPU.arm?
    bin.install "torch" if OS.mac? && Hardware::CPU.intel?
    bin.install "torch" if OS.linux? && Hardware::CPU.arm?
    bin.install "torch" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
