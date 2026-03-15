class TorchCmd < Formula
  desc "mkdir + touch command"
  homepage "https://github.com/toshimaru/torch"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.0/torch-cmd-aarch64-apple-darwin.tar.xz"
      sha256 "07e74beacf20723b2e42c2b73118b9e05ab22453390a4a144af7e7dcec35dcc3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.0/torch-cmd-x86_64-apple-darwin.tar.xz"
      sha256 "06eb33672f5a6efe6a56081ea0116ec6d466fa9a0c778290856bafd588e76ab9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.0/torch-cmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "64e1088f0d52cb02b1862832cfc5fc95967c3cbe66a8376fac55d5ab6e43cdf1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/toshimaru/torch/releases/download/v0.2.0/torch-cmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "15a589942c3e94f849f78aae7b700bec9e6ba490eed9863a0845b5fe88074ea4"
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
