//
//  View + Shadow.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/19/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit



extension UIView {
    func setShadow(color: CGColor = UIColor.lightGray.cgColor, offset: CGSize = .init(width: 0, height: 1), radius: CGFloat = 1, opacity: Float = 0.6) {
        self.layer.shadowColor = color
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
    }
}
