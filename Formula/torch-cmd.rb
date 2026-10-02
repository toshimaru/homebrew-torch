class TorchCmd < Formula
  desc "mkdir + touch command"
  homepage "https://github.com/toshimaru/torch"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.4.0/torch-cmd-aarch64-apple-darwin.tar.xz"
      sha256 "1cec6406384c6b223600b6408e32686d9d3c89a6497ccf79017d9bb459386c6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.4.0/torch-cmd-x86_64-apple-darwin.tar.xz"
      sha256 "8f3a7ea44b3a08f4e245e6fa13923da0635c7bc0a43d2b08bdefd7dc5b747b72"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.4.0/torch-cmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "028b94d3c329efd2cbbd28ca61336666b1ad708beb16161d1e3ba8986693f56f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.4.0/torch-cmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "63e0c3a688c3895de8915b1135ca95179579c815cc1888e8e068bedc684a0e23"
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
