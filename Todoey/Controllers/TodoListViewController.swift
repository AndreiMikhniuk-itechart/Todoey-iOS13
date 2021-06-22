 

import UIKit
import CoreData

class TodoListViewController: UITableViewController{
    var itemArray: [Item] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
  
    
    @IBAction func addTodoAction(_ sender: Any) {
        
        var textField: UITextField?
        
        let allert = UIAlertController(title: "Add todo", message: nil, preferredStyle: .alert)
        
        let allertAction = UIAlertAction(title: "add", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            newItem.title = textField?.text!
            newItem.isDone = false
            self.itemArray.append(newItem)
            self.saveItem();
            
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
       let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        let attributedText : NSMutableAttributedString =  NSMutableAttributedString(string: item.title!)
        attributedText.addAttributes([
                        NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                        NSAttributedString.Key.strikethroughColor: UIColor.lightGray,
                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)
                        ], range: NSMakeRange(0, attributedText.length))
        cell.textLabel!.text = item.title
    
        cell.accessoryType =  item.isDone ?.checkmark : .none
        
           
       return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemArray[indexPath.row]
        item.isDone = !item.isDone
        
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        saveItem()
    }
    
    func saveItem(){
        do {
            
          try  self.context.save()
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            self.itemArray = try context.fetch(request)
            
        } catch {
            print("Error loading context \(error)")
        }
    }
}


