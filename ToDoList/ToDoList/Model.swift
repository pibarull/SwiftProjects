//
//  Model.swift
//  ToDoList
//
//  Created by Илья Ершов on 14/07/2019.
//  Copyright © 2019 Ilia Ershov. All rights reserved.
//

import Foundation


struct toDoItem: Codable {
    var title: String
    var isCompleted: Bool
    
    public init (title: String, isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

struct toDoList: Codable {
    public init() {
        List = []
    }
    var List: [toDoItem] = []
    
    mutating func addItem(nameItem: String, isComplited: Bool = false) {
        let deal = toDoItem.init(title: nameItem, isCompleted: isComplited)
        List.append(deal)
    }
    
    mutating func addItem(toDoItem: toDoItem) {
        List.append(toDoItem)
    }
    
    mutating func changeItem(at index: Int, newTitle: String) {
        List[index].title = newTitle
    }
    
    mutating func removeItem(at index: Int) {
        List.remove(at: index)
    }

    mutating func moveItem (from: Int, to: Int) {
        let itemToMove = List[from]
        removeItem(at: from)
        List.insert(itemToMove, at: to)
    }
    
    mutating func changeState(at item: Int) -> Bool {
        List[item].isCompleted = !(List[item].isCompleted)
        return List[item].isCompleted
    }
}
