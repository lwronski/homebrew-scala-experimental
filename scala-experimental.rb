# typed: false
# frozen_string_literal: true

# Scala Experimental Formula
class ScalaExperimental < Formula
  desc "Experimental launcher for Scala"
  homepage "https://virtuslab.github.io/scala-cli/"
  url (RUBY_PLATFORM.include? "arm64") ?
    "https://github.com/Virtuslab/scala-cli/releases/download/v0.1.16/scala-cli-aarch64-apple-darwin.gz" :
    "https://github.com/Virtuslab/scala-cli/releases/download/v0.1.16/scala-cli-x86_64-apple-darwin.gz"
  version "0.1.16"
  sha256 (RUBY_PLATFORM.include? "arm64") ?
    "386e2031cca3671783079e5e8151284b8f33eec8b50936ed9d58372382d3d2e7" :
    "22fddca9d13717ec39d33db51db07aa621b4179f09db744a9ebe2240194bdded"
  license "Apache-2.0"

  def install
    if (RUBY_PLATFORM.include? "arm64")
      bin.install "scala-cli-aarch64-apple-darwin" => "scala-cli"
    else
      bin.install "scala-cli-x86_64-apple-darwin" => "scala-cli"
    end
    bin.install_symlink "scala-cli" => "scala"
  end

  test do
    (testpath / "Hello.scala").write "object Hello {
                                def main(args: Array[String]): Unit =
                                  println(\"Hello from Scala\")
                              }"
    output = shell_output("#{bin}/scala-cli Hello.scala")
    assert_equal ["Hello from Scala\n"], output.lines
  end
end
