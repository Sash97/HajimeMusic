//
//  Storyboard + Extension.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/12/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit

extension UIStoryboard {
    @nonobjc class var main: UIStoryboard {
        return UIStoryboard(name: Storyboard.main, bundle: nil)
    }
}
