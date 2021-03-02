//
//  ViewController.swift
//  Todoey
//
//  Created by Panchami Rao on 01/03/21.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray=[Item]()
    
    let defaults=UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newitem1=Item()
        newitem1.title="Find mike"
        itemArray.append(newitem1)
        
        let newitem2=Item()
        newitem2.title="Buy eggos"
        itemArray.append(newitem2)
        
        let newitem3=Item()
        newitem3.title="destroy demogorgon"
        itemArray.append(newitem3)
        
        if let items=defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray=items

        }
        
    }

    
    //MARK- Tableview Datasorce methods
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
       // let cell1=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell")
            
        let item=itemArray[indexPath.row]
        
        cell.textLabel?.text=item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
        return cell
    }
    
    //MARK- Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !(itemArray[indexPath.row].done)
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK- Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField=UITextField()
        
        let alert=UIAlertController(title: "Add new todoey item", message:"" , preferredStyle: .alert)
        
        let action=UIAlertAction(title: "Add item", style: .default) { (action) in
            
            let newitem=Item()
            newitem.title=textField.text!
            self.itemArray.append(newitem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create new item"
            textField=alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    

}

