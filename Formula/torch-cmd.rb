class TorchCmd < Formula
  desc "mkdir + touch command"
  homepage "https://github.com/toshimaru/torch"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.1/torch-cmd-aarch64-apple-darwin.tar.xz"
      sha256 "83623d53b4968ca1e9dbdbe49c738753299905aa1c1a896bc1fb884a6e15d25e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.1/torch-cmd-x86_64-apple-darwin.tar.xz"
      sha256 "8ee92edd60bfad98ea74c9671b13342780871c14836c4aa9785197ef3e0ba4b3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.1/torch-cmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f7af27b36aa143be725b90c74fdf9440af62a1f443140e0925f5b0b6d0959d68"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.1/torch-cmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f5d9ef761ef27ae68ec8ca45821ef00f4d6c568e67109c13a3b2ee414b6b6eee"
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
