//
//  Expense.swift
//  swiftDataWithSean
//
//  Created by rania on 19/06/1445 AH.
//

import Foundation
import SwiftData

@Model

class Expense {
    
    var name : String
    var date : Date
    var value : Double
    
    init(name: String, date: Date, value: Double) {
        self.name = name
        self.date = date
        self.value = value
    }
    
}
