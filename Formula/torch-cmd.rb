class TorchCmd < Formula
  desc "mkdir + touch command"
  homepage "https://github.com/toshimaru/torch"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.3/torch-cmd-aarch64-apple-darwin.tar.xz"
      sha256 "11aff258fd98d61234ddaa52f4e0d744a8c87d40f6e0481b6d427ccb3aa0e3d4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.3/torch-cmd-x86_64-apple-darwin.tar.xz"
      sha256 "7a17f639a882a12ceb1898327fc02603093115ec60e8d0852cc8df51b3c119fa"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.3/torch-cmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "162fd75d77612fcb1c5c4f6c9dd22fbe8f725eaf3103ce2c175c3333cdffe0fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.3/torch-cmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c9a4f51054b6a1fc4e174b235c60619906c96c793e33920f7c4efee91a7cdfdd"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "torch"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "torch"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "torch"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "torch"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
