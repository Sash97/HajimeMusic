//
//  Color + RGB.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/23/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit


extension UIColor {
    static func rgb(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
