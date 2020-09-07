//
//  ABSlider.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/28/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit



class ABSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.minX, y: bounds.midY)
        return CGRect(origin: point, size: CGSize(width: bounds.width, height: 18))
    }
}
