//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    let defaults = UserDefaults.standard
    var itemArray: [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "Data") as? [TodoItem] {
            itemArray = items
        }
    }
    
    
    @IBAction func addTodoAction(_ sender: Any) {
        
        var textField: UITextField?
        
        let allert = UIAlertController(title: "Add todo", message: nil, preferredStyle: .alert)
        
        let allertAction = UIAlertAction(title: "add", style: .default) { (action) in
            let newItem = TodoItem(title: textField!.text!)
            self.itemArray.append(newItem)
//            defaults.a
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
        let item = itemArray[indexPath.row]
        cell.textLabel!.text = item.title
        cell.accessoryType =  item.isDone ?.checkmark : .none
           
       return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemArray[indexPath.row]
        item.isDone = !item.isDone
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

