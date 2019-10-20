//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Ricardo Bravo Acuña on 10/19/19.
//  Copyright © 2019 Ricardo Bravo Acuña. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let toDoList = ToDoList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDoList.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        showItemText(for: cell, with: toDoList.list[indexPath.row])
        configureIcon(for: cell, with: toDoList.list[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            configureIcon(for: cell, with: toDoList.list[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func showItemText(for cell: UITableViewCell, with item: Item) {
        if let label = cell.viewWithTag(999) as? UILabel {
            label.text = item.text
        }
    }
    
    private func configureIcon(for cell: UITableViewCell, with item: Item){
        if(item.checked) {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        item.toggleCheck()
    }

}

