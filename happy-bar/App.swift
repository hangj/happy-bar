//
//  App.swift
//  happy-bar
//
//  Created by hangj on 2023/3/18.
//

import Cocoa
import SwiftUI


@main
struct myApp : App {
    // swiftlint:disable:next weak_delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // This is our Scene. We are not using Settings
    var body: some Scene {
      Settings {
        EmptyView()
      }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    static private(set) var instance: AppDelegate!

    // The NSStatusBar manages a collection of status items displayed within a system-wide menu bar.
    lazy var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        AppDelegate.instance = self

        statusItem.menu = Menu(statusItem: statusItem)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
