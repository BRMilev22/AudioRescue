//
//  AudioRescueApp.swift
//  AudioRescue
//
//  Created by Boris Milev on 3.08.25.
//

import SwiftUI
import Cocoa
import UserNotifications

@main
struct AudioRescueApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusBarItem: NSStatusItem!
    private var preferencesWindowController: NSWindowController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupDefaults()
        setupMenuBar()
        
        // Hide any default windows that SwiftUI might create
        for window in NSApplication.shared.windows {
            window.orderOut(nil)
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
    
    func setupDefaults() {
        UserDefaults.standard.register(defaults: ["showNotifications": true])
    }
    
    func setupMenuBar() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusBarItem.button {
            // Try system symbol first, fallback to text if not available
            if let image = NSImage(systemSymbolName: "speaker.wave.3", accessibilityDescription: "Audio Rescue") {
                button.image = image
            } else {
                button.title = "🔊"
            }
            button.action = #selector(showMenu)
            button.target = self
        }
    }
    
    @objc func showMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Reset Audio", action: #selector(resetAudio), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Preferences...", action: #selector(openPreferences), keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusBarItem.menu = menu
        statusBarItem.button?.performClick(nil)
        statusBarItem.menu = nil
    }
    
    @objc func resetAudio() {
        // First try the standard approach
        let script = """
        do shell script "sudo killall coreaudiod" with administrator privileges
        """
        
        let appleScript = NSAppleScript(source: script)
        var error: NSDictionary?
        let result = appleScript?.executeAndReturnError(&error)
        
        if let error = error {
            print("AppleScript error: \(error)")
            // Fallback: try without sudo
            attemptFallbackReset()
        } else {
            print("Audio reset successful")
            showNotification(title: "Audio Reset", message: "Core Audio has been restarted successfully.")
        }
    }
    
    private func attemptFallbackReset() {
        let fallbackScript = """
        do shell script "killall coreaudiod" with administrator privileges
        """
        
        let appleScript = NSAppleScript(source: fallbackScript)
        var error: NSDictionary?
        let result = appleScript?.executeAndReturnError(&error)
        
        if let error = error {
            print("Fallback AppleScript error: \(error)")
            showNotification(title: "Audio Reset Failed", message: "Unable to reset audio. Please run 'sudo killall coreaudiod' in Terminal.")
        } else {
            print("Fallback audio reset successful")
            showNotification(title: "Audio Reset", message: "Core Audio has been restarted successfully.")
        }
    }
    
    @objc func openPreferences() {
        if preferencesWindowController != nil {
            preferencesWindowController?.showWindow(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }
        
        createPreferencesWindow()
    }
    
    private func createPreferencesWindow() {
        let preferencesView = PreferencesView()
        let hostingController = NSHostingController(rootView: preferencesView)
        
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 450, height: 350),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        
        window.contentViewController = hostingController
        window.title = "AudioRescue Preferences"
        window.center()
        
        let windowController = NSWindowController(window: window)
        preferencesWindowController = windowController
        
        windowController.showWindow(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func showNotification(title: String, message: String) {
        let showNotifications = UserDefaults.standard.bool(forKey: "showNotifications")
        guard showNotifications else { return }
        
        DispatchQueue.main.async {
            // Create notification window with larger size for beautiful design
            let notificationWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 380, height: 120),
                styleMask: [.borderless],
                backing: .buffered,
                defer: false
            )
            
            // Position in lower center (like old volume indicator)
            if let screen = NSScreen.main {
                let screenFrame = screen.visibleFrame
                let windowFrame = notificationWindow.frame
                let x = screenFrame.midX - windowFrame.width / 2
                let y = screenFrame.minY + 120 // Lower center
                notificationWindow.setFrameOrigin(NSPoint(x: x, y: y))
            }
            
            // Create liquid glass container
            let containerView = NSView()
            containerView.wantsLayer = true
            containerView.frame = NSRect(x: 0, y: 0, width: 380, height: 120)
            
            // Liquid glass background with blur
            let backgroundLayer = CALayer()
            backgroundLayer.frame = containerView.bounds
            backgroundLayer.cornerRadius = 24
            backgroundLayer.backgroundColor = NSColor.black.withAlphaComponent(0.1).cgColor
            
            // Create visual effect view for blur
            let visualEffectView = NSVisualEffectView()
            visualEffectView.frame = containerView.bounds
            visualEffectView.material = .hudWindow
            visualEffectView.blendingMode = .behindWindow
            visualEffectView.state = .active
            visualEffectView.wantsLayer = true
            visualEffectView.layer?.cornerRadius = 24
            visualEffectView.layer?.masksToBounds = true
            
            // Add subtle border glow
            let borderLayer = CALayer()
            borderLayer.frame = containerView.bounds
            borderLayer.cornerRadius = 24
            borderLayer.borderWidth = 1
            borderLayer.borderColor = NSColor.white.withAlphaComponent(0.2).cgColor
            borderLayer.shadowColor = NSColor.white.withAlphaComponent(0.3).cgColor
            borderLayer.shadowOffset = CGSize(width: 0, height: 0)
            borderLayer.shadowRadius = 8
            borderLayer.shadowOpacity = 0.5
            
            // Create icon background circle
            let iconBackground = CALayer()
            iconBackground.frame = NSRect(x: 30, y: 35, width: 50, height: 50)
            iconBackground.cornerRadius = 25
            iconBackground.backgroundColor = NSColor.systemBlue.withAlphaComponent(0.8).cgColor
            
            // Icon
            let iconLabel = NSTextField(labelWithString: "🔊")
            iconLabel.font = NSFont.systemFont(ofSize: 24)
            iconLabel.alignment = .center
            iconLabel.isBezeled = false
            iconLabel.isEditable = false
            iconLabel.backgroundColor = NSColor.clear
            iconLabel.frame = NSRect(x: 30, y: 35, width: 50, height: 50)
            
            // Title with beautiful typography
            let titleLabel = NSTextField(labelWithString: title)
            titleLabel.font = NSFont.systemFont(ofSize: 18, weight: .semibold)
            titleLabel.textColor = NSColor.labelColor
            titleLabel.isBezeled = false
            titleLabel.isEditable = false
            titleLabel.backgroundColor = NSColor.clear
            titleLabel.frame = NSRect(x: 100, y: 55, width: 250, height: 25)
            
            // Message with subtle styling
            let messageLabel = NSTextField(labelWithString: message)
            messageLabel.font = NSFont.systemFont(ofSize: 14, weight: .regular)
            messageLabel.textColor = NSColor.secondaryLabelColor
            messageLabel.isBezeled = false
            messageLabel.isEditable = false
            messageLabel.backgroundColor = NSColor.clear
            messageLabel.frame = NSRect(x: 100, y: 30, width: 250, height: 20)
            
            // Assemble the view hierarchy
            containerView.addSubview(visualEffectView)
            containerView.layer?.addSublayer(borderLayer)
            containerView.layer?.addSublayer(iconBackground)
            containerView.addSubview(iconLabel)
            containerView.addSubview(titleLabel)
            containerView.addSubview(messageLabel)
            
            notificationWindow.contentView = containerView
            notificationWindow.level = .floating
            notificationWindow.isOpaque = false
            notificationWindow.backgroundColor = NSColor.clear
            
            // Initial state for animation - start scaled down and transparent
            containerView.layer?.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
            containerView.layer?.opacity = 0.0
            
            // Show window
            notificationWindow.makeKeyAndOrderFront(nil)
            
            // Animate in with spring animation
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.6)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(controlPoints: 0.34, 1.56, 0.64, 1.0))
            
            let scaleAnimation = CABasicAnimation(keyPath: "transform")
            scaleAnimation.fromValue = CATransform3DMakeScale(0.8, 0.8, 1.0)
            scaleAnimation.toValue = CATransform3DIdentity
            scaleAnimation.duration = 0.6
            
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = 0.0
            opacityAnimation.toValue = 1.0
            opacityAnimation.duration = 0.4
            
            containerView.layer?.add(scaleAnimation, forKey: "scaleIn")
            containerView.layer?.add(opacityAnimation, forKey: "fadeIn")
            containerView.layer?.transform = CATransform3DIdentity
            containerView.layer?.opacity = 1.0
            
            CATransaction.commit()
            
            // Auto-hide after 2.5 seconds with smooth fade out
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                CATransaction.begin()
                CATransaction.setAnimationDuration(0.4)
                CATransaction.setCompletionBlock {
                    notificationWindow.orderOut(nil)
                }
                
                let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
                fadeOutAnimation.fromValue = 1.0
                fadeOutAnimation.toValue = 0.0
                fadeOutAnimation.duration = 0.4
                
                let scaleOutAnimation = CABasicAnimation(keyPath: "transform")
                scaleOutAnimation.fromValue = CATransform3DIdentity
                scaleOutAnimation.toValue = CATransform3DMakeScale(0.9, 0.9, 1.0)
                scaleOutAnimation.duration = 0.4
                
                containerView.layer?.add(fadeOutAnimation, forKey: "fadeOut")
                containerView.layer?.add(scaleOutAnimation, forKey: "scaleOut")
                containerView.layer?.opacity = 0.0
                containerView.layer?.transform = CATransform3DMakeScale(0.9, 0.9, 1.0)
                
                CATransaction.commit()
            }
        }
    }
    
}
