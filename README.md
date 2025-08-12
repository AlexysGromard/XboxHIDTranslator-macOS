# XboxHIDTranslator-macOS

**XboxHIDTranslator-macOS** is a Swift-based tool for macOS that intercepts Xbox controller HID events, remaps them to a standardized gamepad format, and exposes them as a virtual device.  
This project aims to fix compatibility issues in older games (e.g., Human: Fall Flat) that only detect a limited set of buttons on Xbox controllers when played on macOS.

## 🚀 Features
- Reads raw HID input from Xbox controllers (via `IOHIDManager`)
- Customizable mapping from Xbox-specific usages to standard gamepad usages
- Planned: Virtual gamepad output for full compatibility with legacy games
- Written in Swift for macOS

## 🛠 How it works
1. **Input capture**  
   The app listens for HID events from the Xbox controller, including buttons, triggers, and analog sticks.
2. **Mapping translation**  
   Each input is mapped to a standardized usage ID that is recognized by most game engines.
3. **(Upcoming)** **Virtual device output**  
   The translated input is sent to a virtual gamepad device, which older games can recognize as a fully functional controller.

## 📦 Installation
Currently in early development — cloning and running in Xcode is required.

```bash
git clone https://github.com/AlexysGromard/XboxHIDTranslator-macOS.git
cd XboxHIDTranslator-macOS
open XboxHIDTranslator.xcodeproj
```
