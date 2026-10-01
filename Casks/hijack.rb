cask "hijack" do
  version "1.1.0"
  sha256 "6330e9a378aeaf22ed571b1f794181e73f472ba11deb3367d032d57ffae24bca"

  url "https://github.com/zl190/hijack/releases/download/v#{version}/Hijack.zip"
  name "Hijack"
  desc "Dictate with WeType, Doubao, Sogou or Handy from any input source"
  homepage "https://github.com/zl190/hijack"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Hijack.app"
  binary "#{appdir}/Hijack.app/Contents/MacOS/Hijack", target: "hijack"

  # Not notarized; signed with a fixed self-signed identity so the Accessibility grant survives updates.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Hijack.app"]
    # brew quits Hijack to upgrade it; start it again (a fresh install opens it the first time too)
    # (LaunchServices can refuse the first open right after the bundle is replaced, so retry)
    run "/bin/sh", args: ["-c", "for i in 1 2 3; do sleep 2; /usr/bin/open \"$0\" && exit 0; done; exit 1",
                          "{{appdir}}/Hijack.app"], must_succeed: false, print_stderr: false
  end

  uninstall quit: "com.zl190.hijack"

  zap trash: [
    "~/Library/Logs/Hijack.log",
    "~/Library/Preferences/com.zl190.hijack.plist",
  ]

  caveats "Allow Hijack in System Settings > Privacy & Security > Accessibility."
end
