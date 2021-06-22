//
//  TodoItem.swift
//  Todoey
//
//  Created by Andrey MIkhniuk on 6/15/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation


class Item {
    var title: String = ""
    var isDone: Bool = true
    
    init(title: String) {
          self.title = title
      }
}
