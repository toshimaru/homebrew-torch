class TorchCmd < Formula
  desc "mkdir + touch command"
  homepage "https://github.com/toshimaru/torch"
  version "0.1.1"
  on_macos do
    on_arm do
      url "https://github.com/toshimaru/torch/releases/download/v0.1.1/torch-cmd-aarch64-apple-darwin.tar.xz"
      sha256 "0efb04a91f0d9f07b7810ccc1df6336dde54455890ed1d0682e38e2349e09706"
    end
    on_intel do
      url "https://github.com/toshimaru/torch/releases/download/v0.1.1/torch-cmd-x86_64-apple-darwin.tar.xz"
      sha256 "4644a5a0d54b83eba2673b9659c7a236ca8c2316bac8c005147a7a075c11923b"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/toshimaru/torch/releases/download/v0.1.1/torch-cmd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fed3b3277119cb5ca328003f65f817796e58c7338702b65ac5577f9944044f52"
    end
    on_intel do
      url "https://github.com/toshimaru/torch/releases/download/v0.1.1/torch-cmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c60db9869351610fd834078c31e484995a550a56080abb1c03ccf9978b29676d"
    end
  end
  license "MIT"

  def install
    bin.install "torch"

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end
