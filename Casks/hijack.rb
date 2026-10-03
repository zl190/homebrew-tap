cask "hijack" do
  version "1.1.3"
  sha256 "ba3a1e59ca081d5796311edb5a515932e9078233b6eaa05fb3abe327375b1cd0"

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
