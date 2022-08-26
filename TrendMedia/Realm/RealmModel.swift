//
//  RealmModel.swift
//  TrendMedia
//
//  Created by Y on 2022/08/22.
//

import Foundation
import RealmSwift

class UserShoppingList: Object {
    @Persisted(primaryKey: true) var objectId: ObjectId
    @Persisted var ShoppingFavorite: Bool
    @Persisted var ShoppingDone: Bool
    @Persisted var ShoppingTitle: String
    @Persisted var ShoppingDetail: String
    @Persisted var ShoppingRegisterDate: Date
    @Persisted var ShoppingDoDate: String
    
    convenience init(shoppingTitle: String, shoppingDetail: String) {
        self.init()
        self.ShoppingRegisterDate = Date()
        self.ShoppingDoDate = ShoppingDoDate
        self.ShoppingTitle = shoppingTitle
        self.ShoppingDetail = shoppingDetail
        self.ShoppingFavorite = false
        self.ShoppingDone = false
    }
}
