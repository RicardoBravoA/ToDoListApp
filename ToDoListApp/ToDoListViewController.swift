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
        print(toDoList.list.count)
        return toDoList.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        print("item: \(toDoList.list[indexPath.row].text)")
        if let label = cell.viewWithTag(999) as? UILabel {
            label.text = toDoList.list[indexPath.row].text
        }
        configureIcon(for: cell, at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            configureIcon(for: cell, at: indexPath)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func configureIcon(for cell: UITableViewCell, at indexPath: IndexPath){
        let isCheked = toDoList.list[indexPath.row].checked
        if(isCheked) {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        toDoList.list[indexPath.row].checked = !isCheked
    }

}

