//
//  Extensions.swift
//  poke-list
//
//  Created by Nicola Innocenti on 30/10/21.
//

import Foundation
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    var image: UIImage? {
        return UIImage(named: self)
    }
    var color: UIColor? {
        return UIColor(named: self)
    }
}

extension UIFont {
    class func regular(size: CGFloat) -> UIFont? {
        return UIFont(name: "AvenirNext-Regular", size: size)
    }
    class func medium(size: CGFloat) -> UIFont? {
        return UIFont(name: "AvenirNext-Medium", size: size)
    }
    class func semiBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "AvenirNext-DemiBold", size: size)
    }
    class func bold(size: CGFloat) -> UIFont? {
        return UIFont(name: "AvenirNext-Bold", size: size)
    }
}

extension UIDevice {
    class var isIpad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    class var isPortrait: Bool {
        if #available(iOS 13.0, *) {
            return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.interfaceOrientation == .portrait
        } else {
            return UIApplication.shared.statusBarOrientation == .portrait
        }
    }
}

extension UIImage {
    func paint(with color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

extension UIColor {
    class var navBar: UIColor {
        return UIColor(named: "navbar") ?? .white
    }
    class var navBarTint: UIColor {
        return UIColor(named: "navbar_tint") ?? .black
    }
    class var tabBar: UIColor {
        return UIColor(named: "tabbar") ?? .white
    }
    class var tabBarTint: UIColor {
        return UIColor(named: "tabbar_tint") ?? .black
    }
    class var background: UIColor {
        return UIColor(named: "background") ?? .white
    }
    class var border: UIColor {
        return UIColor(named: "border") ?? .lightGray
    }
    class var heart: UIColor {
        return UIColor(named: "heart") ?? .lightGray
    }
    class var hp: UIColor {
        return UIColor(named: "hp") ?? .lightGray
    }
    class var attack: UIColor {
        return UIColor(named: "attack") ?? .lightGray
    }
    class var defense: UIColor {
        return UIColor(named: "defense") ?? .lightGray
    }
    class var specialAttack: UIColor {
        return UIColor(named: "special_attack") ?? .lightGray
    }
    class var specialDefense: UIColor {
        return UIColor(named: "special_defense") ?? .lightGray
    }
    class var speed: UIColor {
        return UIColor(named: "speed") ?? .lightGray
    }
}

extension UIApplication {
    var safeArea: UIEdgeInsets {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            return window?.safeAreaInsets ?? .zero
        } else {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets ?? .zero
        }
    }
}

extension UIView {
    class var identifier : String {
        return String(describing: self)
    }
    func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    var darker : UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: max(r - 0.10, 0.0), green: max(g - 0.10, 0.0), blue: max(b - 0.10, 0.0), alpha: a)
        }
        return UIColor()
    }
    
    var lighter : UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: min(r + 0.1, 1.0), green: min(g + 0.1, 1.0), blue: min(b + 0.1, 1.0), alpha: a)
        }
        return UIColor()
    }
    
    func getRGB() -> (red:Int, green:Int, blue:Int, alpha:Int)? {
        
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
            
        } else {
            return nil
        }
    }
}

extension AppDelegate {
    class var main : AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

extension UIApplication {
    func loadMainInterface() {
        if #available(iOS 13, *) {
            if let window = keyWindow {
                window.rootViewController = TabBarViewController()
                window.makeKeyAndVisible()
            }
        } else {
            if let window = windows.last {
                window.rootViewController = TabBarViewController()
                window.makeKeyAndVisible()
            }
        }
    }
    var lastSync: TimeInterval? {
        set {
            UserDefaults.standard.set(newValue, forKey: "lastSync")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.double(forKey: "lastSync")
        }
    }
}

extension Locale {
    static var systemLanguage: String {
        if let language = Locale.preferredLanguages.first {
            let split = language.split(separator: "-")
            if split.count > 0 {
                return String(split[0])
            } else {
                return language
            }
        } else {
            return "it"
        }
    }
}
