//
//  Model.swift
//  ToDoList
//
//  Created by Илья Ершов on 14/07/2019.
//  Copyright © 2019 Ilia Ershov. All rights reserved.
//

import Foundation
var toDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "toDoItemsKey")
        UserDefaults.standard.synchronize()
    }
    get{
        if let items = UserDefaults.standard.array(forKey: "toDoItemsKey") as? [[String: Any]] {
            return items
        } else {
            return []
        }
    }
}

//= [["Title": "Позвонить маме", "isCompleted": true], ["Title": "Купить хлеб", "isCompleted": false]]

func addItem(nameItem: String, isComplited: Bool = false) {
    toDoItems.append(["Title": nameItem, "isCompleted" : isComplited])
}

func changeItem(at index: Int, newTitle: String) {
    toDoItems[index]["Title"] = newTitle
}
func moveItem (from: Int, to: Int) {
    let itemToMove = toDoItems[from]
    removeItem(at: from)
    toDoItems.insert(itemToMove, at: to)
}

func removeItem(at index: Int) {
    toDoItems.remove(at: index)
}

func changeState(at item: Int) -> Bool {
    toDoItems[item]["isCompleted"] = !(toDoItems[item]["isCompleted"] as! Bool)
    return toDoItems[item]["isCompleted"] as! Bool
}

