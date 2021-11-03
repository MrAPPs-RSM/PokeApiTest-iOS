//
//  NavigationController.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import UIKit

class NavigationViewController: UINavigationController, UINavigationControllerDelegate {
    private var ignorePush = false

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if !ignorePush {
            super.pushViewController(viewController, animated: animated)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
           ignorePush = true
    }
       
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
           ignorePush = false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIDevice.isIpad ? .allButUpsideDown : .portrait
    }
}
