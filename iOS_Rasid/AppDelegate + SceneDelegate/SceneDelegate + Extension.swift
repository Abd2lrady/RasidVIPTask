//
//  SceneDelegate + Extension.swift
//  iOS_Rasid
//
//  Created by Fintech on 06/11/2022.
//

import UIKit

extension SceneDelegate {
    func bootApp(scene: UIWindowScene) {
        let window = UIWindow(windowScene: scene)
        
        let view = ViewController()
        let navigator = UINavigationController(rootViewController: view)

        window.rootViewController = navigator
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}
