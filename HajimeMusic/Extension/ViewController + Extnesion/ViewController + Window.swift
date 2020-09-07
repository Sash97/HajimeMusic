//
//  ViewController + Window.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/20/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import UIKit


extension UIViewController {
    var window: UIView? {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }
}
