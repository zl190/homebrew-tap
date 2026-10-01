cask "hijack" do
  version "1.0.0"
  sha256 "358b8a71274576993f206143c596adc9c63fffffe15f9a4658151cd56ee7552a"

  url "https://github.com/zl190/hijack/releases/download/v#{version}/Hijack.zip"
  name "Hijack"
  desc "Hold a key to dictate with WeType from any input source"
  homepage "https://github.com/zl190/hijack"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Hijack.app"

  # Not notarized; signed with a fixed self-signed identity so the Accessibility grant survives updates.
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Hijack.app"]
  end

  uninstall quit: "com.zl190.hijack"

  zap trash: [
    "~/Library/Logs/Hijack.log",
    "~/Library/Preferences/com.zl190.hijack.plist",
  ]

  caveats "Allow Hijack in System Settings > Privacy & Security > Accessibility."
end
