class Libpapilo < Formula
  desc "PaPILO as a Presolve-Only Shared Library with C API"
  homepage "https://github.com/Jij-Inc/libpapilo"
  url "https://github.com/Jij-Inc/libpapilo/releases/download/v2.4.3-jij.8/libpapilo-2.4.3-jij.8-Darwin-libpapilo.tar.gz"
  version "2.4.3-jij.8"
  sha256 "7ca1cba37bed7e9107361f2df32145080b03d26acb07a994f7619f37b0f1f17f"
  license "LGPL-3.0"

  depends_on "boost"
  depends_on "tbb"
  depends_on "pkg-config"

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
