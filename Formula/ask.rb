class Ask < Formula
  include Language::Python::Virtualenv

  desc "Terminal-based chat tool for interacting with LLMs via OpenRouter API"
  homepage "https://github.com/kentaroh-toyoda/terminal-chat"
  url "https://github.com/kentaroh-toyoda/terminal-chat/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "283236d50acdb2a6860bbe1fe5033ca90bcb1eb97f7d76edf5c79a535ea56192"
  license "MIT"
  head "https://github.com/kentaroh-toyoda/terminal-chat.git", branch: "main"

  depends_on "python@3.12"

  def install
    # Create virtualenv and install package with dependencies
    venv = virtualenv_create(libexec, "python3.12")
    system libexec/"bin/pip", "install", "-v", "--no-deps",
           "--ignore-installed",
           buildpath
    system libexec/"bin/pip", "install", "-v",
           "requests>=2.31.0",
           "python-dotenv>=1.0.0",
           "rich>=13.7.0",
           "prompt_toolkit>=3.0.43",
           "keyring>=24.0.0"

    bin.install_symlink libexec/"bin/ask"
  end

  test do
    # Test that the ask command exists
    assert_match "terminal", shell_output("#{bin}/ask --help 2>&1", 0).downcase
  end
end
