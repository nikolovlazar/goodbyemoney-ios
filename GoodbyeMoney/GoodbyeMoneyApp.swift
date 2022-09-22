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
            if let env = Bundle.main.infoDictionary?["SENTRY_ENVIRONMENT"] as? String {
                options.debug = env == "development"
                options.environment = env
            }
            if let tracesSampleRate = Bundle.main.infoDictionary?["SENTRY_TRACES_SAMPLE_RATE"] as? String {
                options.tracesSampleRate = NSNumber(value: Double(tracesSampleRate)!)
            }
            if let profilesSampleRate = Bundle.main.infoDictionary?["SENTRY_PROFILES_SAMPLE_RATE"] as? String {
                options.profilesSampleRate = NSNumber(value: Double(profilesSampleRate)!)
            }
            options.enableAppHangTracking = true
            options.enableUserInteractionTracing = true
            options.attachViewHierarchy = true
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
