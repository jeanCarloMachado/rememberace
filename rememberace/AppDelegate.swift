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

        let getOneItem = NSMenuItem()
        getOneItem.title = "Give me a quote"
        getOneItem.action = #selector(showQuote(_:))
        menu.insertItem(getOneItem, at: 0)

        statusBar.menu = menu

        let minutesBetweenNotifications: Double = 12
        let interval : Double = minutesBetweenNotifications * 60
        //scheduling
        let date = Date().addingTimeInterval(interval)
        let timer = Timer(fireAt: date, interval: interval, target: self, selector: #selector(showQuote(_:)), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }

    @objc func showQuote(_ obj: NSMenuItem) {
        let result = "bash -c 'source /Users/jeanmachado/.bashrc && /Users/jeanmachado/projects/rememberRandom/getRemember.sh'".run()

        var notification = NSUserNotification()
        notification.informativeText = result
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }


    @objc func quit(_ obj: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}

extension String {
    func run() -> String? {
        let pipe = Pipe()
        let process = Process()
        process.launchPath = "/bin/sh"
        process.arguments = ["-c", self]
        process.standardOutput = pipe

        let fileHandle = pipe.fileHandleForReading
        process.launch()

        return String(data: fileHandle.readDataToEndOfFile(), encoding: .utf8)
    }
}
