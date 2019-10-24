//
//  Item.swift
//  ToDoListApp
//
//  Created by Ricardo Bravo Acuña on 10/19/19.
//  Copyright © 2019 Ricardo Bravo Acuña. All rights reserved.
//

import Foundation

class Item : NSObject {
    var text = ""
    var checked = false
    
    func toggleCheck(){
        checked = !checked
    }
}
