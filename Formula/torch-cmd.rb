class TorchCmd < Formula
  desc "mkdir + touch command"
  homepage "https://github.com/toshimaru/torch"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.3.1/torch-cmd-aarch64-apple-darwin.tar.xz"
      sha256 "7d0b108c4519419c4b2a40ab2914bed099d600003da37ec0d90e56a71f97047a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.3.1/torch-cmd-x86_64-apple-darwin.tar.xz"
      sha256 "9232b3e2b8a7f2736e5ad6780209ce81a376308190446036e468df177e127cce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.3.1/torch-cmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1c4e64c449afa9b5972583a5a3ec410cf4a32dfe7e059a47c7477233f1d84384"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.3.1/torch-cmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "10e67e33cda4f822ac05c76945e433cd6437bc683ac17825688e784c3618aa73"
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
