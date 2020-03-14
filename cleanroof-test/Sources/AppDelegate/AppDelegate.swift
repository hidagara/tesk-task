//
//  AppDelegate.swift
//  cleanroof-test
//
//  Created by Roman Guseynov on 11.03.2020.
//  Copyright © 2020 Roman Guseynov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    
    DispatchQueue.global(qos: .background).async {
      Auth.auth().signInAnonymously()
    }
    
    
    let vc = DeviceListVC()
    vc.viewModel = DeviceListVM()
    let nvc = UINavigationController(rootViewController: vc)
    window = UIWindow(frame: UIScreen.main.bounds)
    window!.rootViewController = nvc
    window!.makeKeyAndVisible()
    
    return true
  }
  
}

