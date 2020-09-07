//
//  View + Animate.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/23/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit


extension UIView {
    static func customAnimate(withDuration: TimeInterval = 0.55, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.55,
                       delay: 0,
                       usingSpringWithDamping: 0.75,
                       initialSpringVelocity: 0.75,
                       options: [],
                       animations: {
                        animations()
        }, completion: { successed in
            completion?(successed)
        })
    }
}
