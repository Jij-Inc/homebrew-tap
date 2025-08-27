class Libpapilo < Formula
  desc "PaPILO as a Presolve-Only Shared Library with C API"
  homepage "https://github.com/Jij-Inc/libpapilo"
  url "https://github.com/Jij-Inc/libpapilo/releases/download/v2.4.3-jij.7/libpapilo-2.4.3-jij.7-Darwin-libpapilo.tar.gz"
  version "2.4.3-jij.7"
  sha256 "e5e14eaf1e6c840a1a0915de064027dcd358a593c40ad321359bc9d930cea651"
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
