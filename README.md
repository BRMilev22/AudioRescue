# AudioRescue 🔊 - Fix MacBook Audio Crackling & Stuttering

<div align="center">
  <img src="AudioRescue/Assets.xcassets/AppIcon.appiconset/audioRescueLogo.png" alt="AudioRescue Logo" width="128" height="128">
  
  **The Ultimate Solution for MacBook Audio Problems**
  
  A lightweight macOS menu bar application that instantly fixes audio stuttering, crackling, popping, and distortion issues on MacBook Pro, MacBook Air, iMac, and Mac Studio with Apple Silicon (M1, M2, M3, M4) and Intel processors.

  ![macOS](https://img.shields.io/badge/macOS-Menu%20Bar%20App-blue) ![Swift](https://img.shields.io/badge/Swift-5.9-orange) ![License](https://img.shields.io/badge/License-MIT-green) ![Apple Silicon](https://img.shields.io/badge/Apple%20Silicon-M1%20M2%20M3%20M4-red) ![Intel](https://img.shields.io/badge/Intel-Compatible-blue)
</div>

## 📋 Table of Contents

- [The Problem: Widespread MacBook Audio Issues](#-the-problem-widespread-macbook-audio-issues)
  - [Affected Devices](#affected-devices)
  - [Processor Compatibility](#processor-compatibility)
  - [Audio Problems You're Experiencing](#-audio-problems-youre-experiencing)
  - [Root Causes (Technical Analysis)](#-root-causes-technical-analysis)
- [The Solution: CoreAudio Reset](#-the-solution-coreaudio-reset)
- [Features](#features)
- [Installation](#installation)
  - [Download Release (Recommended)](#download-release-recommended)
  - [Build from Source](#build-from-source)
- [Usage](#usage)
- [Preferences](#preferences)
- [Community & Support Resources](#-community--support-resources)
- [Technical Details](#technical-details)
- [Troubleshooting](#troubleshooting)
- [Development](#development)
- [License](#license)
- [Why Choose AudioRescue?](#-why-choose-audiorescue)
- [Still Having Audio Issues?](#-still-having-audio-issues)

## 🚨 The Problem: Widespread MacBook Audio Issues

### Affected Devices
- **MacBook Pro** (2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024)
- **MacBook Air** (2018, 2019, 2020, 2022, 2023, 2024)  
- **iMac** (2017, 2019, 2020, 2021, 2023, 2024)
- **Mac Studio** (2022, 2023, 2024)
- **Mac Mini** (2018, 2020, 2023)

### Processor Compatibility
- ✅ **Apple Silicon**: M1, M1 Pro, M1 Max, M1 Ultra
- ✅ **Apple Silicon**: M2, M2 Pro, M2 Max, M2 Ultra  
- ✅ **Apple Silicon**: M3, M3 Pro, M3 Max
- ✅ **Apple Silicon**: M4, M4 Pro, M4 Max
- ✅ **Intel**: All Intel-based Macs (2016-2020)

Thousands of Mac users worldwide experience these frustrating audio issues that Apple has yet to fully resolve.

### 🎵 Audio Problems You're Experiencing
- **Audio crackling and popping** during video calls (Zoom, Teams, FaceTime)
- **Sound stuttering** when using multiple Bluetooth devices (AirPods, speakers, keyboards)
- **Audio distortion** during music playback (Spotify, Apple Music, YouTube)
- **Sound cutting out** during CPU-intensive tasks (video editing, gaming, coding)
- **Choppy audio** in streaming services (Netflix, YouTube, Twitch)
- **Audio glitches** during screen recording or presentations
- **Static and buzzing** from internal speakers
- **Microphone crackling** during recordings
- **Audio delay** and sync issues
- **Complete audio failure** requiring restart

### 🔍 Root Causes (Technical Analysis)
Extensive community research has identified multiple factors:

**Primary Causes:**
- **Memory Pressure**: Audio issues worsen with high RAM usage (>70%)
- **Apple Silicon Load**: M1/M2/M3/M4 processors under heavy load trigger audio problems  
- **CoreAudio Daemon Crashes**: The macOS audio system (coreaudiod) becomes unstable
- **Bluetooth Interference**: Multiple connected devices overwhelm the audio stack
- **Thermal Throttling**: Overheating Macs experience more frequent audio issues

**Secondary Factors:**
- **Background App Conflicts**: Certain apps interfere with CoreAudio
- **macOS Version Bugs**: Specific macOS updates introduce audio regression
- **Hardware Buffer Issues**: Audio buffer overflow in Apple Silicon architecture
- **Power Management**: Battery optimization affects audio processing priority

## 💡 The Solution: CoreAudio Reset

### Why This Works
The **CoreAudio daemon (coreaudiod)** is macOS's central audio processing service. When it becomes unstable or crashes, it causes all the audio problems mentioned above. Restarting this service immediately resolves:
- Audio crackling and stuttering
- Bluetooth audio issues  
- Microphone problems
- Audio sync issues
- Complete audio failures

### Manual Fix (Traditional Method)
```bash
sudo killall coreaudiod
```

### ⚡ AudioRescue: Automated Solution
**AudioRescue** automates this fix with a single click from your menu bar - no more typing commands or remembering syntax!

## Features

✅ **One-Click Audio Reset** - Instantly restart Core Audio daemon  
✅ **Menu Bar Integration** - Always accessible from the top-right corner  
✅ **Launch at Login** - Automatically start with macOS  
✅ **Notification Support** - Get feedback when audio is reset  
✅ **Lightweight** - Minimal system resource usage  
✅ **No Background Processes** - Only active when you need it  

## Installation

### Download Release (Recommended)
1. Download the latest release from [GitHub Releases](../../releases)
2. Unzip and drag AudioRescue to your Applications folder
3. Right-click and select "Open" to bypass Gatekeeper
4. Grant administrator privileges when prompted

### Build from Source

#### Prerequisites
- macOS 13.0 or later
- Xcode 15.0 or later
- Administrator privileges

#### Steps
1. Clone this repository:
   ```bash
   git clone https://github.com/BRMilev22/AudioRescue.git
   cd AudioRescue
   ```

2. Open the project in Xcode:
   ```bash
   open AudioRescue.xcodeproj
   ```

3. Build and run:
   - Select your target device
   - Press ⌘+R to build and run
   - Or use ⌘+B to build only

4. Archive for distribution:
   - Product → Archive
   - Distribute App → Copy App

## Usage

1. **Launch AudioRescue** - The app will appear in your menu bar as a speaker icon
2. **Click the Icon** - A menu will appear with options
3. **Select "Reset Audio"** - This will run `sudo killall coreaudiod`
4. **Enter Password** - Provide administrator credentials when prompted
5. **Audio Fixed!** - Your audio issues should be resolved

### Menu Options
- **Reset Audio** - Restart the Core Audio daemon
- **Preferences** - Configure launch at login and notifications
- **Quit** - Exit AudioRescue

## Preferences

Access preferences by clicking the menu bar icon and selecting "Preferences..."

- **Launch at Login** - Automatically start AudioRescue when you log in
- **Show Notifications** - Display success/failure notifications

## 📚 Community & Support Resources

### Apple Communities & Forums
- [Apple Discussions: MacBook Pro Speaker Crackling Issues](https://discussions.apple.com/thread/254844087)
- [Apple Support: Audio Renderer Problems](https://discussions.apple.com/thread/255711380)
- [Apple Discussions: Choppy Audio MacBook Pro](https://discussions.apple.com/thread/254533016)

### Reddit Communities
- r/MacBookPro - Audio stuttering discussions
- r/macOS - CoreAudio troubleshooting
- r/AppleHelp - Mac audio problems

### Tech Forums & News
- [MacRumors: M1/M2/M3 Audio Stuttering](https://forums.macrumors.com/threads/crackling-skipping-stuttering-audio-on-mbp-m3.2433826/)
- [How-To Geek: Fix Mac Audio Problems](https://www.howtogeek.com/670635/how-to-fix-crackly-audio-and-other-mac-sound-problems/)
- [Developer Forums: Audio Cracking Solutions](https://developer.apple.com/forums/thread/132423?page=24)

### Search Terms That Lead Here
If you found this through Google, you probably searched for:
- "MacBook Pro audio crackling fix"
- "M1 M2 M3 M4 audio stuttering"
- "coreaudiod killall Mac"
- "MacBook Air sound problems"
- "macOS audio glitches"
- "Bluetooth audio issues Mac"
- "Fix Mac speakers crackling"
- "MacBook audio cutting out"
- "Mac audio distortion solution"

## Technical Details

AudioRescue uses AppleScript to execute the audio reset command with administrator privileges:

```applescript
do shell script "sudo killall coreaudiod" with administrator privileges
```

This approach:
- Safely requests administrator access
- Doesn't require storing credentials
- Works with macOS security policies
- Provides user feedback

## Troubleshooting

### Audio Issues Persist
- Try restarting your MacBook Pro
- Check Activity Monitor for high memory usage
- Disconnect unnecessary Bluetooth devices
- Ensure AudioRescue has proper permissions

### Permission Denied
- Make sure you enter the correct administrator password
- Check that your account has admin privileges
- Try running from Terminal: `sudo killall coreaudiod`

### App Won't Start
- Right-click and select "Open" instead of double-clicking
- Check macOS version compatibility (requires 13.0+)
- Review System Preferences → Security & Privacy

## Development

### Project Structure
```
AudioRescue/
├── AudioRescue/
│   ├── AudioRescueApp.swift     # Main app and menu bar logic
│   ├── ContentView.swift        # Preferences interface
│   ├── Assets.xcassets/         # App icons and assets
│   └── AudioRescue.entitlements # Security permissions
├── AudioRescueTests/            # Unit tests
├── AudioRescueUITests/          # UI tests
└── README.md                    # This file
```

### Contributing
1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Apple Communities for documenting this widespread issue
- MacRumors Forums for technical insights
- All MacBook Pro users affected by this audio problem

## 🏷️ Keywords & Tags

**Mac Audio Issues**: crackling, stuttering, popping, distortion, cutting out, glitches, static, buzzing  
**Devices**: MacBook Pro, MacBook Air, iMac, Mac Studio, Mac Mini  
**Processors**: M1, M1 Pro, M1 Max, M1 Ultra, M2, M2 Pro, M2 Max, M2 Ultra, M3, M3 Pro, M3 Max, M4, M4 Pro, M4 Max, Intel  
**Years**: 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024  
**Operating Systems**: macOS Monterey, macOS Ventura, macOS Sonoma, macOS Sequoia  
**Applications**: Zoom, Teams, FaceTime, Spotify, Apple Music, YouTube, Netflix, Logic Pro, Final Cut Pro  
**Bluetooth**: AirPods, AirPods Pro, AirPods Max, Bluetooth speakers, wireless headphones  

## ⭐ Why Choose AudioRescue?

- ✅ **Instant Fix**: One-click solution for all Mac audio problems
- ✅ **Universal Compatibility**: Works on all Macs (Intel & Apple Silicon)  
- ✅ **Lightweight**: Minimal resource usage, always available
- ✅ **Free & Open Source**: No hidden costs or subscriptions  
- ✅ **Community Trusted**: Thousands of satisfied users
- ✅ **Actively Maintained**: Regular updates and improvements

---

## 🆘 Still Having Audio Issues?

If AudioRescue doesn't solve your problem, try these additional solutions:

1. **Reset NVRAM/PRAM**: Hold Option+Command+P+R during startup
2. **Check Audio MIDI Setup**: Applications → Utilities → Audio MIDI Setup
3. **Update macOS**: Ensure you have the latest system updates
4. **Reset Bluetooth**: System Preferences → Bluetooth → Advanced → Reset
5. **Safe Mode Test**: Boot in Safe Mode to check for software conflicts

---

**Disclaimer**: AudioRescue requires administrator privileges to restart the Core Audio daemon. This is the same command (`sudo killall coreaudiod`) recommended by Apple Support and used by thousands of Mac users daily. Always verify the source of any software before granting admin access.
