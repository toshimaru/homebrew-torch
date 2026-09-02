class TorchCmd < Formula
  desc "mkdir + touch command"
  homepage "https://github.com/toshimaru/torch"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.3.0/torch-cmd-aarch64-apple-darwin.tar.xz"
      sha256 "3daf43dd55381efda34ea28f043f91f492a7292530167f29dbeea227163c1e28"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.3.0/torch-cmd-x86_64-apple-darwin.tar.xz"
      sha256 "6a4958d4aa6246849f7c125cc6c66d71e44f5ffc3b4f5135fae07ffcb059f64f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.3.0/torch-cmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a0f71f69f2484fbdf0b98b6b63a5a268ceed9cced7d4fc8f05409acf7152843e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.3.0/torch-cmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8138e90e9503feca9c76a3cf8d0919f0d3969a460661147d769f9e633868de50"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-pc-windows-gnu":            {},
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
