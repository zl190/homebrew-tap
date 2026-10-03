cask "hijack" do
  version "1.1.2"
  sha256 "ba0e95c77240f344907a1171cb2436326058d407e191160c38429651d1f65e49"

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
  end

  uninstall quit: "com.zl190.hijack"

  zap trash: [
    "~/Library/Logs/Hijack.log",
    "~/Library/Preferences/com.zl190.hijack.plist",
  ]

  caveats "Open Hijack once, then allow it in Privacy & Security > Accessibility. Updates reopen it."
end
