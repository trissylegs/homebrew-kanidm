class Kanidm < Formula
  desc "Kanidm CLI"
  homepage "https://github.com/kanidm/kanidm"
  url "https://github.com/kanidm/kanidm/archive/refs/tags/v1.1.0-alpha.11.tar.gz"
  sha256 "78c12b14441c554edce8ff3801bd31878e25c474098d64d4bb4d06165c559027"
  license "Mozilla Public License 2.0"
  head "https://github.com/kanidm/kanidm.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end


  depends_on "rust" => :build

  def install
    system "cargo", "install", "--bin", "kanidm", "--path", "kanidm_tools", "--locked", "--root", *prefix

    # Completion scripts and manpage are generated in the crate's build
    # directory, which includes a fingerprint hash. Try to locate it first
    out_dir = Dir["target/release/build/kanidm-*/out"].first
  end

  test do
    system "#{bin}/kanidm", "--version"
  end
end
