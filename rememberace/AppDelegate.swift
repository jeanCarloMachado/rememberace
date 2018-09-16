//
//  AppDelegate.swift
//  rememberace
//
//  Created by Jean Machado on 15.09.18.
//  Copyright © 2018 Jean Machado. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusBar = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        let icon = NSImage(named: NSImage.Name(rawValue: "statusIcon"))
        icon?.isTemplate = true
        statusBar.image = icon

        let menu = NSMenu()
        menu.autoenablesItems = true
        let quitItem = NSMenuItem()
        quitItem.title = "Quit"
        quitItem.action = #selector(quit(_:))
        menu.insertItem(quitItem, at: 0)
        statusBar.menu = menu
    }

    @objc func quit(_ obj: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

}

