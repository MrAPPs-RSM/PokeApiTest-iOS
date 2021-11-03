//
//  TabBarController.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewControllerA = HomeViewController()
        viewControllerA.tabBarItem = UITabBarItem(
            title: "pokemons".localized,
            image: "poke_ball".image,
            selectedImage: "poke_ball".image?.paint(with: .tabBarTint)
        )
        viewControllerA.tabBarItem.imageInsets.top = UIApplication.shared.safeArea.bottom > 0 ? 4 : 0
        viewControllerA.tabBarItem.imageInsets.bottom = 2
        
        let viewControllerB = FavoritesViewController()
        viewControllerB.tabBarItem = UITabBarItem(
            title: "favorites".localized,
            image: "tab_heart".image,
            selectedImage: "tab_heart".image?.paint(with: .tabBarTint)
        )
        
        viewControllers = [
            NavigationViewController(rootViewController: viewControllerA),
            NavigationViewController(rootViewController: viewControllerB)
        ]
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIDevice.isIpad ? .allButUpsideDown : .portrait
    }
}
