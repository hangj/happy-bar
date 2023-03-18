//
//  menu.swift
//  happy-bar
//
//  Created by hangj on 2023/3/17.
//


import AppKit

class Menu: NSMenu, NSMenuDelegate {
    static let menuWidth = 300

    required init(coder decoder: NSCoder) {
      super.init(coder: decoder)
    }
    init() {
        super.init(title: "happy-bar")
        self.delegate = self
        self.minimumWidth = CGFloat(Menu.menuWidth)
    }

    func menuWillOpen(_ menu: NSMenu) {
        print("menu will open")
    }
    
    func menuDidClose(_ menu: NSMenu) {
        print("menu did close")
    }
}
