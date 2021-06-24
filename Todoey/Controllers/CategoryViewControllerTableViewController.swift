//
//  CategoryViewControllerTableViewController.swift
//  Todoey
//
//  Created by Andrey MIkhniuk on 24.06.21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewControllerTableViewController: UITableViewController {
    var categories: [`CategoryItem`] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    @IBAction func addCategoryPressed(_ sender: UIBarButtonItem) {
        var textField : UITextField?
        let alertController = UIAlertController(title: "Add a new Category", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "add", style: .default) { action in
            let newCategory = CategoryItem(context: self.context)
            newCategory.title = textField?.text!
            self.categories.append(newCategory)
            self.save()
        }
        alertController.addTextField { alertTextField in
            alertTextField.placeholder = "Category"
            textField = alertTextField
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    func loadCategories(){
        let request : NSFetchRequest<CategoryItem> = CategoryItem.fetchRequest()
        do {
            self.categories = try context.fetch(request)
        } catch {
            print("Error loading context \(error)")
        }
        tableView.reloadData()
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        tableView.reloadData()
    }
    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Provide a cell object for each row.
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = categories[indexPath.row]
        cell.textLabel!.text = item.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
    }

}
