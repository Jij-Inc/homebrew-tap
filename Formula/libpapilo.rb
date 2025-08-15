class Libpapilo < Formula
  desc "PaPILO as a Presolve-Only Shared Library with C API"
  homepage "https://github.com/Jij-Inc/libpapilo"
  url "https://github.com/Jij-Inc/libpapilo/releases/download/v2.4.3-jij.1/libpapilo-2.4.3-jij.1-Darwin-libpapilo.tar.gz"
  version "2.4.3-jij.1"
  sha256 "68aad83e0f22b446c98a39362a3253e8fe48206a350bbe0e259a95239a07e2f0"
  license "LGPL-3.0"

  def install
    include.install "include/libpapilo.h"
    lib.install Dir["lib/*"]
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include "libpapilo.h"
      int main() { return 0; }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lpapilo", "-o", "test"
    system "./test"
  end
end
