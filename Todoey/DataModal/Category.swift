//
//  Category.swift
//  Todoey
//
//  Created by sachin sharma on 28/05/19.
//  Copyright © 2019 sachin sharma. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
