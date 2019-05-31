//
//  ViewController.swift
//  Todoey
//
//  Created by sachin sharma on 09/05/19.
//  Copyright © 2019 sachin sharma. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController{
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    var selectedCategory: Category?{
        didSet{
            loadItems()
        }
    }
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
//    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//        }
       
    }
    //MARK - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Items Added"
        }
//        if item.done == true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        return cell
        
    }
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
//                    realm.delete(item)
                    item.done = !item.done
                }
            }catch{
                print("Error saving done status")
            }
        }
        tableView.reloadData()
        
        
      tableView.deselectRow(at: indexPath, animated: true)
        // hello this is table view
        
        
    }
    //MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when user taps the add button
            print("success")
            
            
            if let currentCategory = self.selectedCategory{
                do{
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
                }catch{
                    print("Errors Saving New Items,\(error)")
                }
            }
            
            
            self.tableView.reloadData()
//            self.defaults.setValue(self.itemArray, forKey: "TodoListArray")
            
            
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create New Item"
            print(alertTextfield.text)
            textField = alertTextfield
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    //MARK: Modal Manupulation Methods
    
//    func saveItems(){
//
//        do{
//           try context.save()
//        }catch{
//            print("Error saving context \(error)")
//        }
//        self.tableView.reloadData()
//    }
    
    
    func loadItems(){

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
//       let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate{
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
//        }else{
//            request.predicate = categoryPredicate
//        }
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
////       request.predicate = compoundPredicate
//
//        do{
//            itemArray = try context.fetch(request)
//        }catch{
//            print("Error fetching data from context \(error)")
//        }
        tableView.reloadData()
    }
}
  //MARK: search bar methods
extension TodoListViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
            tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}
