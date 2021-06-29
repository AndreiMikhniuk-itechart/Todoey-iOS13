//
//  File.swift
//  Todoey
//
//  Created by Andrey MIkhniuk on 29.06.21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class ItemRealm: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isDone: Bool = false
    convenience init(title: String, isDone: Bool = false) {
        self.init()
        self.title = title
        self.isDone = isDone
    }
}
