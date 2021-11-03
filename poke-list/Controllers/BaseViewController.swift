//
//  BaseControllerController.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIDevice.isIpad ? .allButUpsideDown : .portrait
    }
}
