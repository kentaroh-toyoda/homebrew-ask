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
    # Use virtualenv with PEP 517 build
    venv = virtualenv_create(libexec, Formula["python@3.12"].opt_bin/"python3.12")

    # Install build backend
    venv.pip_install "setuptools"
    venv.pip_install "wheel"

    # Install the package
    venv.pip_install_and_link buildpath
  end

  test do
    # Test that the ask command exists
    assert_match "terminal", shell_output("#{bin}/ask --help 2>&1", 0).downcase
  end
end
