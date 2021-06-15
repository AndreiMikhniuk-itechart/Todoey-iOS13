//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    var itemArray = ["Item 1", "Item 2", "Item 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addTodoAction(_ sender: Any) {
        
        var textField: UITextField?
        
        let allert = UIAlertController(title: "Add todo", message: nil, preferredStyle: .alert)
        
        let allertAction = UIAlertAction(title: "add", style: .default) { (action) in
            print(textField?.text)
            self.itemArray.append( textField!.text!)
            self.tableView.reloadData()
            
        }
        allert.addAction(allertAction
        )
        
        allert.addTextField(
            configurationHandler: { allertTextField in
                allertTextField.placeholder = "Todo"
                textField = allertTextField
        })

        present(allert, animated: true) {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate type.
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
       
       // Configure the cell’s contents.
        cell.textLabel!.text = itemArray[indexPath.row]
           
       return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
       
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

