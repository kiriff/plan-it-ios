//
//  TasksManager.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import Foundation
import Firebase
import FirebaseDatabase

class APIManager: NSObject {
    private override init() {}
    static let shared = APIManager()
    var ref = Database.database().reference()
    
    public var tasks: [Task] = []
    
    func addTask(_ task: Task) {
        print("add task")
        if let user = Auth.auth().currentUser, let dict = task.dictionary {
            ref.child("users/\(user.uid)/tasks").childByAutoId().setValue(dict)
        }
    }
    
    func updateTask(_ task: Task) {
        print("update task")
        if let user = Auth.auth().currentUser, let dict = task.dictionary {
            ref.child("users/\(user.uid)/tasks/\(task.id)").setValue(dict)
        }
    }
    
    func removeTask(_ task: Task) {
        print("remove task")
        if let user = Auth.auth().currentUser {
            ref.child("users/\(user.uid)/tasks/\(task.id)").removeValue()
        }
    }
    
    func getListTasks(successBlock: @escaping (([Task]) -> ())) {
        print("get list task")
        if let user = Auth.auth().currentUser {
            ref.child("users/\(user.uid)/tasks").observe(DataEventType.value, with: { (snapshot) in
                var tasksArray = [Task]()
                for child in snapshot.children {
                    if let child = child as? DataSnapshot, let dict = child.value as? [String : Any] {
                        let id = child.key
                        var dictWithId = dict
                        dictWithId["id"] = id
                        let task = Task.object(dictWithId)
                        tasksArray.append(task)
                    }
                }
                self.tasks = tasksArray
                successBlock(tasksArray)
            })
        }
    }
}
