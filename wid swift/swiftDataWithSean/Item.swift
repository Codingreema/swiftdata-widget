//
//  Item.swift
//  swiftDataWithSean
//
//  Created by rania on 19/06/1445 AH.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
