//
//  OpenUrlHandler.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 7/11/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

extension UIWindow {
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}

class OpenUrlHandler {
    
    class func getIdFromURL(concertUrl url: URL) {
        
        let allowedCharset = CharacterSet
            .decimalDigits
        
        let toStringUrl = String(describing: url)
        
        let filteredId = String(toStringUrl.unicodeScalars.filter(allowedCharset.contains))
        
        guard let toIntegerId = Int(filteredId) else { return }

        openConcert(concertId: toIntegerId)
    }
    
    class func openConcert(concertId id: Int) {
        
            let concertController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConcertInfoViewController") as! ConcertInfoViewController
        concertController.conertId = id
        UIApplication.shared.keyWindow?.topViewController()?.navigationController?.pushViewController(concertController, animated: true)
    }
    
}
