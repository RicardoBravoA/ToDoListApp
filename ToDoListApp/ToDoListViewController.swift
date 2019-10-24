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
    @IBAction func addItem(_ sender: Any) {
        let newRowIndex = toDoList.list.count
        _ = toDoList.addItem()
        let indexPath = IndexPath(row: newRowIndex, section:    0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        toDoList.list.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
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
        guard let checkmark = cell.viewWithTag(998) as? UILabel else {
            return
        }
        if(item.checked) {
            checkmark.text = "✓"
        }else{
            checkmark.text = ""
        }
        item.toggleCheck()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let addTableViewController = segue.destination as? AddTableViewController {
                addTableViewController.delegate = self
            }
        } else if segue.identifier == "EditItemSegue" {
            if let addTableViewController = segue.destination as? AddTableViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = toDoList.list[indexPath.row]
                    addTableViewController.item = item
                    addTableViewController.delegate = self
                }
            }
        }
    }

}

extension ToDoListViewController: AddItemViewControllerDelegate {
    
    func addItemViewControllerDidCancel(_ controller: AddTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: AddTableViewController, didFinishAdding item: Item) {
        navigationController?.popViewController(animated: true)
        let rowIndex = toDoList.list.count
        toDoList.list.append(item)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func addItemViewController(_ controller: AddTableViewController, didFinishEditing item: Item) {
        navigationController?.popViewController(animated: true)
        if let index = toDoList.list.firstIndex(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                showItemText(for: cell, with: item)
            }
        }
    
    }
    
}
