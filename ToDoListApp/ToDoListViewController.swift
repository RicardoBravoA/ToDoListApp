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
    var tableData = [[Item?]?]()
    
    @IBAction func addItem(_ sender: Any) {
        /*
        let newRowIndex = toDoList.list.count
        _ = toDoList.addItem()
        let indexPath = IndexPath(row: newRowIndex, section:    0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        */
    }
    
    @IBAction func deleteItems(_ sender: Any) {
        if let selectedRows = tableView.indexPathsForSelectedRows {
            var items = [Item]()
            for indexPath in selectedRows {
                items.append(toDoList.list[indexPath.row])
            }
            toDoList.delete(items: items)
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .automatic)
            tableView.endUpdates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
        
        let sectionTitleCount = UILocalizedIndexedCollation.current().sectionTitles.count
        var allSections = [[Item?]?](repeating: nil, count: sectionTitleCount)
        var sectionNumber = 0
        let collation = UILocalizedIndexedCollation.current()
        for item in toDoList.list {
            sectionNumber = collation.section(for: item, collationStringSelector: #selector(getter: Item.text))
            if(allSections[sectionNumber] == nil){
                allSections[sectionNumber] = [Item?]()
            }
            allSections[sectionNumber]!.append(item)
        }
        tableData = allSections
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section] == nil ? 0 : tableData[section]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        if let item = tableData[indexPath.section]?[indexPath.row] {
            showItemText(for: cell, with: item)
            configureIcon(for: cell, with: item)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        toDoList.list.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            return
        }
        
        if let cell = tableView.cellForRow(at: indexPath){
            let item = toDoList.list[indexPath.row]
            item.toggleCheck()
            configureIcon(for: cell, with: item)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        toDoList.move(item: toDoList.list[sourceIndexPath.row], index: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    private func showItemText(for cell: UITableViewCell, with item: Item) {
        if let toDoCell = cell as? ToDoListTableViewCell {
            toDoCell.cellTextLabel.text = item.text
        }
    }
    
    private func configureIcon(for cell: UITableViewCell, with item: Item){
        guard let todoCell = cell as? ToDoListTableViewCell else {
            return
        }
        if(item.checked) {
            todoCell.checkLabel.text = "✓"
        }else{
            todoCell.checkLabel.text = ""
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !tableView.isEditing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddItemSegue" {
            if let itemDetailViewController = segue.destination as? ItemDetailViewController {
                itemDetailViewController.delegate = self
            }
        } else if segue.identifier == "EditItemSegue" {
            if let itemDetailViewController = segue.destination as? ItemDetailViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = toDoList.list[indexPath.row]
                    itemDetailViewController.item = item
                    itemDetailViewController.delegate = self
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        tableData.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        UILocalizedIndexedCollation.current().sectionTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        UILocalizedIndexedCollation.current().section(forSectionIndexTitle: index)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        UILocalizedIndexedCollation.current().sectionTitles[section]
    }

}

extension ToDoListViewController: ItemDetailViewControllerDelegate {
    
    
    
    func addItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: Item) {
        navigationController?.popViewController(animated: true)
    
        // George was here!!!
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
            let rowIndex = self.toDoList.list.count
            self.toDoList.list.append(item)
            let indexPath = IndexPath(row: rowIndex, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func addItemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: Item) {
        navigationController?.popViewController(animated: true)
        if let index = toDoList.list.firstIndex(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                showItemText(for: cell, with: item)
            }
        }
    
    }
    
}
