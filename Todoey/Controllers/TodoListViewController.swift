 
 
 import UIKit
 import CoreData
 
 class TodoListViewController: UITableViewController {
    
    var selectedCategoty: CategoryItem? {
        didSet {
            loadItems(withFilter: "")
        }
    }
    
    
    var itemArray: [Item] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    
    @IBAction func addTodoAction(_ sender: Any) {
        var textField: UITextField?
        let allert = UIAlertController(title: "Add todo", message: nil, preferredStyle: .alert)
        let allertAction = UIAlertAction(title: "add", style: .default) { (action) in
            let newItem = Item(context: self.context)
            newItem.title = textField?.text!
            newItem.isDone = false
            newItem.parentCategory = self.selectedCategoty
            self.itemArray.append(newItem)
            self.saveItem();
        }
        allert.addAction(allertAction)
        allert.addTextField(
            configurationHandler: { allertTextField in
                allertTextField.placeholder = "Todo"
                textField = allertTextField })
        present(allert, animated: true) {
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Provide a cell object for each row.
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel!.text = item.title
        cell.accessoryType =  item.isDone ?.checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemArray[indexPath.row]
        item.isDone = !item.isDone
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
    
    func loadItems(withFilter searchText: String) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        var compound : NSCompoundPredicate
        if (selectedCategoty != nil) {
            let predicate1 = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCategoty!.title!)
            compound = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1])
            if(!searchText.isEmpty) {
                let predicate2 = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
                compound = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1, predicate2])
                request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            }
            request.predicate = compound
            do {
                self.itemArray = try context.fetch(request)
            } catch {
                print("Error loading context \(error)")
            }
            tableView.reloadData()
        }
    }
 }
 
 //MARK: - Search bar methods
 
 extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadItems(withFilter:  searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text!.isEmpty) {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder();
            }
        }
        loadItems(withFilter: searchBar.text!)
    }
 }
