//
//  Listbook.swift
//  ToDoList
//
//  Created by Илья Ершов on 19/08/2019.
//  Copyright © 2019 Ilia Ershov. All rights reserved.
//

import Foundation

var lists: [[String: Any]] {
        set{
            var newTitle: [String] = []
            var newContent: [toDoList] = []
            var newToDoItemList: [[toDoItem]] = []
            var a: [Data?] = []
            
            var i = 0
            
            
            for toDoLists in newValue {
                newTitle.append(toDoLists["listTitle"] as! String)
                newContent.append((toDoLists["content"] as? toDoList)!)
                newToDoItemList.append(newContent[i].List)
                a.append(try? PropertyListEncoder().encode(newToDoItemList[i]))
                i += 1
            }
            UserDefaults.standard.set(newTitle, forKey: "toDoListsKeyTitle")
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newContent), forKey: "toDoListsKey")
            UserDefaults.standard.set(a, forKey: "toDoItemsKey")
            UserDefaults.standard.synchronize()
    
        }
        get {
            if let titles = UserDefaults.standard.array(forKey: "toDoListsKeyTitle") as? [String] {
                var listsRes: [[String: Any]] = []
                var toDoItemsRes: [[toDoItem]] = []
                
                let data = (UserDefaults.standard.value(forKey: "toDoListsKey") as? Data)!
                var contentRes = try? PropertyListDecoder().decode(Array<toDoList>.self, from: data)
                if let data2 = UserDefaults.standard.object(forKey: "toDoItemsKey") as? [Data?] {
                    var i = 0
                    for codedItems in data2 {
                        toDoItemsRes.append(try! PropertyListDecoder().decode(Array<toDoItem>.self, from: codedItems!))
                        i += 1
                    }
                    
                    if contentRes!.count-1 >= 0 {
                        for i in 0 ... contentRes!.count-1 {
                            contentRes![i].List = toDoItemsRes[i]
                        }
                    }
                }
                
                var i = 0
                for title in titles {
                    listsRes.append(["listTitle": title, "content": contentRes?[i] as Any])
                    i += 1
                }
                return listsRes
            } else {
                return []
            }
        }
}

func addList(nameList: String, content: toDoList) {
    
    lists.append(["listTitle": nameList, "content": content])
}

func changeListName(at index: Int, newTitle: String) {
    lists[index]["listTitle"] = newTitle
}
func moveList (from: Int, to: Int) {
    let itemToMove = lists[from]
    removeList(at: from)
    lists.insert(itemToMove, at: to)
}

func removeList(at index: Int) {
    lists.remove(at: index)
}
