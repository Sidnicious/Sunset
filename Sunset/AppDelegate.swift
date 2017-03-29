//
//  AppDelegate.swift
//  Sunset
//
//  Created by Sidney San Martín on 3/10/15.
//  Copyright (c) 2015 Coordinated Hackers. All rights reserved.
//

import Cocoa
import ApplicationServices

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let temperatureManager = TemperatureManager()
    let statusItem = NSStatusBar.system().statusItem(withLength: 22)
    @IBOutlet var statusMenu: NSMenu!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.menu = statusMenu
        statusItem.button!.title = "☀"
        
        temperatureManager.scanDisplays()
        for display in temperatureManager.displays {
//            let info = ColorSyncDeviceCopyDeviceInfo(
//                kColorSyncDisplayDeviceClass.takeUnretainedValue(),
//                CGDisplayCreateUUIDFromDisplayID(display.id).takeRetainedValue()
//            ).takeRetainedValue()
//            println("info: \(info)")
            
            let profile = ColorSyncProfileCreateWithDisplayID(display.id).takeRetainedValue()
            print("profile: \(profile)")
            print("sigs: \(ColorSyncProfileCopyTagSignatures(profile).takeRetainedValue())")
        }
        
        CGDisplayRegisterReconfigurationCallback_Swift { display, flags in
            print("AW YIS: \(display) \(flags)")
//            for display in Display.onlineDisplays() {
//                display.setTemperature(2000)
//            }
        }
        
        temperatureManager.target = 2700
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func sliderChanged(_ sender: NSSlider) {
        temperatureManager.target = sender.doubleValue
    }


}

