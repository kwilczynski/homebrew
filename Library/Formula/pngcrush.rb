class Pngcrush < Formula
  desc "Optimizer for PNG files"
  homepage "http://pmt.sourceforge.net/pngcrush/"
  url "https://downloads.sourceforge.net/project/pmt/pngcrush/1.7.86/pngcrush-1.7.86.tar.gz"
  sha256 "e24cd6355736622f94bfc67852da32a0e5eecdecff10293a16ed085573822f63"

  bottle do
    cellar :any
    sha256 "9f851839d271eaf8b187b03cece732cf7f0df2ed5ec3d0459cf1ffbbadebf390" => :yosemite
    sha256 "8d538283858ed3448775ac27c309093bdb13e42eef7b3d60fb1904d6d0c02f0c" => :mavericks
    sha256 "7b582ec740c86f3fb2829cdaa9b9cf9ba7941186d1b55458387ae2db3f9b1e8c" => :mountain_lion
  end

  def install
    # Required to enable "-cc" (color counting) option (disabled by default
    # since 1.5.1)
    ENV.append_to_cflags "-DPNGCRUSH_COUNT_COLORS"

    system "make", "CC=#{ENV.cc}",
                   "LD=#{ENV.cc}",
                   "CFLAGS=#{ENV.cflags}",
                   "LDFLAGS=#{ENV.ldflags}"
    bin.install "pngcrush"
  end

  test do
    system "#{bin}/pngcrush", test_fixtures("test.png"), "/dev/null"
  end
end
