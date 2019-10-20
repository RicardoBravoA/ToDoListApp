//
//  ToDoList.swift
//  ToDoListApp
//
//  Created by Ricardo Bravo Acuña on 10/19/19.
//  Copyright © 2019 Ricardo Bravo Acuña. All rights reserved.
//

import Foundation

class ToDoList {
    
    var list = [Item]()
    
    init() {
        for i in 1...5 {
            let item = Item()
            item.text = "Text \(i)"
            list.append(item)
        }
    }
    
}
