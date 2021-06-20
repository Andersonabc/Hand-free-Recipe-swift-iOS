//
//  AppDelegate.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/19.
//

import UIKit
import Firebase

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
