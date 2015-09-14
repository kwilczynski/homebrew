class GitFlowAvh < Formula
  desc "AVH edition of git-flow"
  homepage "https://github.com/petervanderdoes/gitflow-avh"
  url "https://github.com/petervanderdoes/gitflow-avh/archive/1.8.0.tar.gz"
  sha256 "350665a9de7a9fe58ab82df5ef70c4e6c4f95bf844e30c23e2f3486396727511"

  head do
    url "https://github.com/petervanderdoes/gitflow-avh.git", :branch => "develop"

    resource "completion" do
      url "https://github.com/petervanderdoes/git-flow-completion.git", :branch => "develop"
    end
  end

  resource "completion" do
    url "https://github.com/petervanderdoes/git-flow-completion/archive/0.5.1.tar.gz"
    sha256 "5c8547a549dc623a8d57cfc22c3fa88588f5630da9dc6de9638e5b69da9d47d0"
  end

  depends_on "gnu-getopt"

  conflicts_with "git-flow"

  def install
    system "make", "prefix=#{libexec}", "install"
    (bin/"git-flow").write <<-EOS.undent
      #!/bin/bash
      export FLAGS_GETOPT_CMD=#{Formula["gnu-getopt"].opt_bin}/getopt
      exec "#{libexec}/bin/git-flow" "$@"
    EOS

    resource("completion").stage do
      bash_completion.install "git-flow-completion.bash"
      zsh_completion.install "git-flow-completion.zsh"
    end
  end

  test do
    system "#{bin}/git-flow", "version"
  end
end
