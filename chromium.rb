class Chromium < Formula
  desc "Open-source web browser"
  homepage "https://www.chromium.org/getting-involved/download-chromium"
  url "https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Mac%2F511608%2Fchrome-mac.zip?generation=1508971787553833&alt=media"
  version "c511608"
  sha256 "e129236942b6bd6ab06dd53d86b4e7b425cea06e2df4efc23f5c8b53f49377d6"

  option "with-exec-script", "Install a script for easy CLI opening of Chromium"

  def install
    libexec.install "Chromium.app"

    if build.with? "exec-script"
      exec_script = bin/"chromium"
      exec_script.write <<-EOS.undent
        #!/usr/bin/env bash
        exec open -a "Chromium" "$@"
      EOS
      exec_script.chmod 0555
    end
  end

  def caveats; <<-EOS.undent
    Homebrew has chosen to deprecate the linkapps function, which is a step
    towards killing the usefulness and support of installing .apps through
    Homebrew formulae completely. That decision is out of my hands, sorry.

    You can work around this once linkapps stops functioning by doing:
      cp -rf #{opt_libexec}/Chromium.app /Applications
    Or start using the sha256-verified Cask I've added to this tap:
      brew cask install mac-chromium

    Please note that Homebrew currently has no automatic upgrade functionality
    for casks, so if you go down that route you will need to periodically run:
      brew cask reinstall mac-chromium
  EOS
  end
end
