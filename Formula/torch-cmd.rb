class TorchCmd < Formula
  desc "mkdir + touch command"
  homepage "https://github.com/toshimaru/torch"
  version "0.1.0"
  on_macos do
    on_arm do
      url "https://github.com/toshimaru/torch/releases/download/v0.1.0/torch-cmd-aarch64-apple-darwin.tar.xz"
      sha256 "9840a0e7a3f6a53d8265c0d316900f9c84f39d93f4247cf6896ba44f3091af84"
    end
    on_intel do
      url "https://github.com/toshimaru/torch/releases/download/v0.1.0/torch-cmd-x86_64-apple-darwin.tar.xz"
      sha256 "71a3e4cd8409e6d12b1fd515c91747b067f432ccfd63c453197aa27a7d29ee9e"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/toshimaru/torch/releases/download/v0.1.0/torch-cmd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3ea4e32b34c5e44b55440829249ad9c529ec85b40665740b0368a50d059272ff"
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
