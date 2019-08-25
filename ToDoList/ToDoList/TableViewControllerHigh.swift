//
//  TableViewController.swift
//  ToDoList
//
//  Created by Илья Ершов on 14/07/2019.
//  Copyright © 2019 Ilia Ershov. All rights reserved.
//

import UIKit
var INDEX: Int = 0

class TableViewControllerHigh: UITableViewController {
    
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Новый список", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Новый список"
        }
        
        let createAction = UIAlertAction(title: "Создать", style: .default)
        {
            (alert) in
            let newList = toDoList.init()
            addList(nameList: alertController.textFields![0].text!, content: newList)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        {
            (alert) in
            
        }
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        
        if !tableView.isEditing {
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.init(cgColor: #colorLiteral(red: 0.998498261, green: 0.9936606288, blue: 0.8962557912, alpha: 1))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    //    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    //
    //    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lists.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellList", for: indexPath)
        
        // Configure the cell...
        let currentItem = lists[indexPath.row]
        
        cell.textLabel?.text = currentItem["listTitle"] as? String
        //var text = cell.textLabel?.text
        //if text!.count > 30 {
            //cell.textLabel!.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
            //cell.textLabel!.numberOfLines = 0
        //}
        
        if tableView.isEditing {
            cell.textLabel?.alpha = 0.4
            cell.imageView?.alpha = 0.4
        } else {
            cell.textLabel?.alpha = 1
            cell.imageView?.alpha = 1
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let alertController1 = UIAlertController(title: "Изменить список", message: "", preferredStyle: .alert)
            
            alertController1.addTextField { (textField) in
                textField.text = lists[indexPath.row]["ListTitle"] as? String
            }
            
            let createAction1 = UIAlertAction(title: "Изменить", style: .default)
            {
                (alert) in
                changeListName(at: indexPath.row, newTitle: alertController1.textFields![0].text!)
                //addItem(nameItem: alertController.textFields![0].text!)
                self.tableView.reloadData()
            }
            let cancelAction1 = UIAlertAction(title: "Отмена", style: .cancel)
            {
                (alert) in
            }
            alertController1.addAction(createAction1)
            alertController1.addAction(cancelAction1)
            
            present(alertController1, animated: true, completion: nil)
            
            tableView.setEditing(!tableView.isEditing, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.tableView.reloadData()
            }
            
        } else {
            INDEX = indexPath.row
            //print(INDEX)
            //lists[indexPath.row]["content"] = toDoItems
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeList(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        moveList(from: fromIndexPath.row, to: to.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
        
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
