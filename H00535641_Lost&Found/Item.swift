//
//  Item.swift
//  H00535641_Lost&Found
//
//

import Foundation
import SwiftData

// one lost or found post (SwiftData model)
@Model
class Item {
    var title: String
    var details: String
    var category: String
    var place: String
    var phone: String
    var isLost: Bool
    var isReturned: Bool
    var date: Date

    init(title: String, details: String, category: String, place: String, phone: String, isLost: Bool, date: Date) {
        self.title = title
        self.details = details
        self.category = category
        self.place = place
        self.phone = phone
        self.isLost = isLost
        self.isReturned = false
        self.date = date
    }
}
