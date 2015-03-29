//
//  AppDelegate.swift
//  Sunset
//
//  Created by Sidney San Martín on 3/10/15.
//  Copyright (c) 2015 Coordinated Hackers. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(22)
    @IBOutlet var statusMenu: NSMenu!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusItem.menu = statusMenu
        statusItem.button!.title = "☀"
        
        for display in Display.onlineDisplays() {
            display.setTemperature(8)
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    @IBAction func sliderChanged(sender: NSSlider) {
        let temperature = sender.integerValue
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            for display in Display.onlineDisplays() {
                display.setTemperature(temperature)
            }
        }
    }


}

