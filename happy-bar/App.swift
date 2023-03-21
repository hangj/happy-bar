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

    private var menus: [Menu] = []


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        AppDelegate.instance = self

        menus.append(Menu(title: "😊"))
        menus.append(Menu(title: "😄"))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
