class Kanidm < Formula
  desc "Kanidm CLI"
  homepage "https://github.com/kanidm/kanidm"
  url "https://github.com/kanidm/kanidm/archive/refs/tags/v1.1.0-alpha.12.tar.gz"
  sha256 "6c1e807278e1f90d2ede930dcc612c0da1b6f9e18ed4046771cbaa125af4d296"
  license "Mozilla Public License 2.0"
  head "https://github.com/kanidm/kanidm.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end


  depends_on "rust" => :build

  def install
    system "cargo", "install", "--bin", "kanidm", "--path", "tools", "--locked", "--root", *prefix

    # Completion scripts and manpage are generated in the crate's build
    # directory, which includes a fingerprint hash. Try to locate it first
    out_dir = Dir["target/release/build/kanidm-*/out"].first
  end

  test do
    system "#{bin}/kanidm", "--version"
  end
end
