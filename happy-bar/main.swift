//
//  main.swift
//  happy-bar
//
//  Created by hangj on 2023/3/17.
//

import AppKit


// 1
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate

// 2
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
