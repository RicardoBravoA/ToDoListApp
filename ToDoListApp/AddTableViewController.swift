//
//  AddTableViewController.swift
//  ToDoListApp
//
//  Created by Ricardo Bravo Acuña on 10/20/19.
//  Copyright © 2019 Ricardo Bravo Acuña. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func add(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textfield.becomeFirstResponder()
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        nil
    }
    
}

extension AddTableViewController: UITextFieldDelegate {
    
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
