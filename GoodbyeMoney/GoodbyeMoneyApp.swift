//
//  GoodbyeMoneyApp.swift
//  GoodbyeMoney
//
//  Created by Lazar Nikolov on 2022-09-15.
//
import Sentry
import SwiftUI

@main
struct GoodbyeMoneyApp: App {
    init() {
        SentrySDK.start { options in
            options.dsn = ProcessInfo.processInfo.environment["SENTRY_DSN"]
            options.debug = true // Enabled debug when first installing is always helpful
            options.environment = ProcessInfo.processInfo.environment["SENTRY_ENV"]
            
            // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
            // We recommend adjusting this value in production.
            options.tracesSampleRate = NSNumber(value: (ProcessInfo.processInfo.environment["SENTRY_TRACES_SAMPLE_RATE"]! as NSString).integerValue)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
