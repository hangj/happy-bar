//
//  menu.swift
//  happy-bar
//
//  Created by hangj on 2023/3/17.
//

import AppKit
import SwiftUI
import WebKit
//import Cocoa


class Menu: NSMenu, NSMenuDelegate {
    private weak var statusItem: NSStatusItem?
    static let menuWidth = 300

    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    init(statusItem: NSStatusItem) {
        super.init(title: "happy-bar")
        statusItem.behavior = .removalAllowed

        print("init main menu")

        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "1.circle", accessibilityDescription: "1")
            // button.title = "😄"
        }

        self.statusItem = statusItem
        self.delegate = self
        self.minimumWidth = CGFloat(Menu.menuWidth)

        setup()
    }

    func menuWillOpen(_ menu: NSMenu) {
        print("menu will open")
    }

    func menuDidClose(_ menu: NSMenu) {
        print("menu did close")
    }

    private func setup() {
//        let webview = WebPanelView(request: URLRequest(url: URL(string: "https://hangj.cnblogs.com")!))
//        let viewController = NSHostingController(rootView: webview)
//        viewController.view.frame.size = CGSize(width: Menu.menuWidth, height: 200)
        let webItem: NSMenuItem = {
            let item = NSMenuItem()
            let webview = WebPanelView(request: URLRequest(url: URL(string: "https://hangj.cnblogs.com")!))
            let viewController = NSHostingController(rootView: webview)
            viewController.view.frame.size = CGSize(width: Menu.menuWidth, height: 200)
            item.view = viewController.view
            return item
        }()
        self.addItem(webItem)


        let header: NSMenuItem = {
            let item = NSMenuItem()
            // https://stackoverflow.com/questions/65082604/is-there-a-way-to-load-swiftui-view-into-nsview
            let ui = SwiftUIView() //.frame(width: 100, height: 100, alignment: .center)
            let contentView = NSHostingController(rootView: ui)
            // Setting a size for our now playing view
            contentView.view.frame.size = CGSize(width: Menu.menuWidth, height: 200)
            item.view = contentView.view
            return item
        }()
        self.addItem(header)

        let one = NSMenuItem(title: "One", action: #selector(didTapOne) , keyEquivalent: "1")
        one.target = self
        self.addItem(one)

        let three = NSMenuItem(title: "Three", action: #selector(didTapThree) , keyEquivalent: "3")
        three.target = self
        self.addItem(three)

        let l = NSMenuItem(title: "cnblogs", action: #selector(linkSelector), keyEquivalent: "")
        l.representedObject = "https://hangj.cnblogs.com"
        l.target = self
        self.addItem(l)

        self.addItem(NSMenuItem.separator())

        let aboutMenuItem = NSMenuItem(title: "about", action: #selector(about), keyEquivalent: "")
        aboutMenuItem.target = self
        self.addItem(aboutMenuItem)

        let quit = NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "q")
        quit.target = self
        self.addItem(quit)
    }
    
    private func changeStatusBarButton(number: Int) {
        if let button = statusItem?.button {
            button.image = NSImage(systemSymbolName: "\(number).circle", accessibilityDescription: number.description)
        }
    }

    @objc func didTapOne() {
        changeStatusBarButton(number: 1)
    }

    @objc func didTapThree() {
        changeStatusBarButton(number: 3)

//        self.popUp(positioning: nil, at: NSEvent.mouseLocation, in: nil)


//        if let frame = NSScreen.forPopup?.visibleFrame {
//            self.popUp(positioning: nil, at: NSRect.centered(ofSize: self.size, in: frame).origin, in: nil)
//            print("for Popup")
//            return
//        }
        if let frame = NSWorkspace.shared.frontmostApplication?.windowFrame {
            self.popUp(positioning: nil, at: NSRect.centered(ofSize: self.size, in: frame).origin, in: nil)
            print("frontmost Application")
            return
        }
    }

    // The selector that takes a link and opens it
    // in your default browser
    @objc func linkSelector(sender: NSMenuItem) {
        let link = sender.representedObject as! String
        guard let url = URL(string: link) else { return }
        NSWorkspace.shared.open(url)
    }

    // The selector that opens a standard about pane.
    // You can see we also customise what appears in our
    // about pane by creating a Credits.html file in the root
    // of the project
    @objc func about(sender: NSMenuItem) {
        NSApp.orderFrontStandardAboutPanel()
    }

    // The selector that quits the app
    @objc func quit(sender: NSMenuItem) {
        NSApp.terminate(self)
//        NSApplication.terminate(_:)
    }

}

extension NSRunningApplication {
  var windowFrame: NSRect? {
    let options = CGWindowListOption(arrayLiteral: [.excludeDesktopElements, .optionOnScreenOnly])
    let windowListInfo = CGWindowListCopyWindowInfo(options, CGWindowID(0))
    if let windowInfoList = windowListInfo as NSArray? as? [[String: AnyObject]] {
      for info in windowInfoList {
        if let windowPID = info["kCGWindowOwnerPID"] as? UInt32, windowPID == processIdentifier {
          if let screen = NSScreen.screens.first,
             let topLeftX = info["kCGWindowBounds"]?["X"] as? Double,
             let topLeftY = info["kCGWindowBounds"]?["Y"] as? Double,
             let width = info["kCGWindowBounds"]?["Width"] as? Double,
             let height = info["kCGWindowBounds"]?["Height"] as? Double {
            var rect = NSRect(x: topLeftX, y: topLeftY, width: width, height: height)
            // Convert CGWindowBounds to NSScreen coordinates
            // http://www.krizka.net/2010/04/20/converting-between-kcgwindowbounds-and-nswindowframe
            rect.origin.y = screen.frame.size.height - rect.origin.y - rect.size.height
            return rect
          }
        }
      }
    }

    return nil
  }
}

extension NSScreen {
  static var forPopup: NSScreen? {
    let desiredScreen = 0 // UserDefaults.standard.popupScreen
    if desiredScreen == 0 || desiredScreen > NSScreen.screens.count {
      return NSScreen.main
    } else {
      return NSScreen.screens[desiredScreen - 1]
    }
  }
}

extension NSRect {
  static func centered(ofSize size: NSSize, in frame: NSRect) -> NSRect {
    let topLeftX = (frame.width - size.width) / 2 + frame.minX
    var topLeftY = (frame.height + size.height) / 2 + frame.minY
    if frame.height < size.height {
      topLeftY = frame.maxY
    }

    return NSRect(x: topLeftX + 1.0, y: topLeftY + 1.0, width: size.width, height: size.height)
  }
}
