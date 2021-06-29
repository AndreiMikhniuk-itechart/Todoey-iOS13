//
//  CategoryRealm.swift
//  Todoey
//
//  Created by Andrey MIkhniuk on 29.06.21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryRealm: Object {
    @objc dynamic var title: String = ""
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
