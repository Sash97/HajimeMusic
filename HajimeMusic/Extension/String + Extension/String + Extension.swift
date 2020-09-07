//
//  String + Extension.swift
//  HajimeMusic
//
//  Created by Aleksandr Bagdasaryan on 8/28/20.
//  Copyright © 2020 Aleksandr Bagdasaryan. All rights reserved.
//

import Foundation


extension String {
    private func convertTimeIntervalIntoStringForPlayer(timeInterval: TimeInterval) -> String {
        return "\(Int(timeInterval / 60)):\((Int(timeInterval) % 60) < 10 ? "0\(Int(timeInterval) % 60)" : "\(Int(timeInterval) % 60)")"
    }
    
    init(timeInterval: TimeInterval) {
        self.init()
        self = self.convertTimeIntervalIntoStringForPlayer(timeInterval: timeInterval)
    }
}
