class Libpapilo < Formula
  desc "PaPILO as a Presolve-Only Shared Library with C API"
  homepage "https://github.com/Jij-Inc/libpapilo"
  url "https://github.com/Jij-Inc/libpapilo/releases/download/v2.4.3-jij.5/libpapilo-2.4.3-jij.5-Darwin-libpapilo.tar.gz"
  version "2.4.3-jij.5"
  sha256 "d30da0eeb784b3b30a291d2c5d74969526c2629255034c21188ef3257b035397"
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
