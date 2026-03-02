cask "reverse-scroll-cli" do
  version "0.1.1"
  sha256 "e7d65cd8cffb03c6f51b4827c3f2c2877c565a0741acef61695653171e36cdee"

  url "https://github.com/dongzhenye/reverse-scroll-cli/releases/download/v#{version}/ReverseScrollCLI.app.zip"
  name "ReverseScrollCLI"
  desc "Lightweight CLI daemon to reverse mouse scroll direction on macOS"
  homepage "https://github.com/dongzhenye/reverse-scroll-cli"

  depends_on macos: ">= :ventura"

  app "ReverseScrollCLI.app"
  binary "#{appdir}/ReverseScrollCLI.app/Contents/MacOS/reverse-scroll-cli"

  postflight do
    system_command "cp",
      args: [
        "#{staged_path}/LaunchAgent/com.dongzhenye.reverse-scroll-cli.plist",
        "#{ENV["HOME"]}/Library/LaunchAgents/"
      ],
      sudo: false
    system_command "launchctl",
      args: ["load", "#{ENV["HOME"]}/Library/LaunchAgents/com.dongzhenye.reverse-scroll-cli.plist"],
      sudo: false
  end

  uninstall_postflight do
    system_command "launchctl",
      args: ["unload", "#{ENV["HOME"]}/Library/LaunchAgents/com.dongzhenye.reverse-scroll-cli.plist"],
      sudo: false
    system_command "rm",
      args: ["-f", "#{ENV["HOME"]}/Library/LaunchAgents/com.dongzhenye.reverse-scroll-cli.plist"],
      sudo: false
  end
end
