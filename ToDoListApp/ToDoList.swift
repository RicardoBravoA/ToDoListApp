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
    
    func addItem() -> Item{
        let item = Item()
        item.text = "New Item"
        list.append(item)
        return item
    }
    
    func move(item: Item, index: Int){
        guard let currentIndex = list.firstIndex(of: item) else {
            return
        }
        list.remove(at: currentIndex)
        list.insert(item, at: index)
    }
    
}
