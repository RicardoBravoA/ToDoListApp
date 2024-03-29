//
//  AddTableViewController.swift
//  ToDoListApp
//
//  Created by Ricardo Bravo Acuña on 10/20/19.
//  Copyright © 2019 Ricardo Bravo Acuña. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController {

    weak var delegate: ItemDetailViewControllerDelegate?
    weak var todoList: ToDoList?
    weak var item: Item?
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.addItemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func add(_ sender: Any) {
        if let itemToEdit = item, let text = textfield.text {
            item?.text = text
            delegate?.addItemDetailViewController(self, didFinishEditing: itemToEdit)
        } else {
            let item = Item()
            if let text = textfield.text {
                item.text = text
            }
            delegate?.addItemDetailViewController(self, didFinishAdding: item)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = item {
            title = "Edit Item"
            textfield.text = item.text
        }else {
            title = "New Item"
        }
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textfield.becomeFirstResponder()
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        nil
    }
    
}

protocol ItemDetailViewControllerDelegate: class {
    func addItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func addItemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: Item)
    func addItemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: Item)
}

extension ItemDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textfield.text, let stringRange = Range(range, in: oldText) else {
            return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            btnAdd.isEnabled = false
        }else{
            btnAdd.isEnabled = true
        }
        return true
    }
    
}
