class Libpapilo < Formula
  desc "PaPILO as a Presolve-Only Shared Library with C API"
  homepage "https://github.com/Jij-Inc/libpapilo"
  url "https://github.com/Jij-Inc/libpapilo/releases/download/v3.0.0-jij.2/libpapilo-3.0.0-jij.2-Darwin-libpapilo.tar.gz"
  version "3.0.0-jij.2"
  sha256 "e4df09540826550b2a845bae86fb30063dc96365153ffb922473eecf29236df0"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
    regex(/^v?(\d+\.\d+\.\d+-jij\.\d+)$/i)
  end

  depends_on "boost"
  depends_on "pkg-config"
  depends_on "tbb"

  def install
    include.install "include/libpapilo.h"
    lib.install Dir["lib/*"]
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "libpapilo.h"
      int main() { return 0; }
    EOS
    flags = shell_output("pkg-config --cflags --libs libpapilo").strip.split
    system ENV.cc, "test.c", *flags, "-o", "test"
    system "./test"
  end
end
