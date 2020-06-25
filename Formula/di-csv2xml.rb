class DiCsv2xml < Formula
  desc "Convert CSV to Blue Yonder Supply & Demand API compatible XML"
  homepage "https://github.com/blue-yonder/di-csv2xml"
  url "https://github.com/blue-yonder/di-csv2xml/archive/v2.0.2.tar.gz"
  sha256 "5b243fe6d7f9179c092068d6b252a0ed71dc71e2a80a373302dbaf6a54d19eb3"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    (testpath/"test.csv").write <<~EOS
      A,B,C,D
      1,2,3,4
    EOS
    (testpath/"test.xml").write <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <Category>
      \t<Record>
      \t\t<A>1</A>
      \t\t<B>2</B>
      \t\t<C>3</C>
      \t\t<D>4</D>
      \t</Record>
      </Category>
    EOS
    assert_equal (testpath/"test.xml").read.strip,
      shell_output("#{bin}/di-csv2xml --category Category --input test.csv").strip
  end
end
