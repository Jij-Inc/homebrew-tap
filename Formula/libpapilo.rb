class Libpapilo < Formula
  desc "PaPILO as a Presolve-Only Shared Library with C API"
  homepage "https://github.com/Jij-Inc/libpapilo"
  url "https://github.com/Jij-Inc/libpapilo/releases/download/v2.4.3-jij.10/libpapilo-2.4.3-jij.10-Darwin-libpapilo.tar.gz"
  version "2.4.3-jij.10"
  sha256 "f04c14856110635c60cd622d94489668b92e9fd55e53edc0de0f6ff2c1d8b224"
  license "LGPL-3.0"

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
