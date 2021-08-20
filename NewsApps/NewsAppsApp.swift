//
//  NewsAppsApp.swift
//  NewsApps
//
//  Created by Adrian Suryo Abiyoga on 20/08/21.
//

import SwiftUI

@main
struct NewsAppsApp: App {
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(articleBookmarkVM)
        }
    }
}
