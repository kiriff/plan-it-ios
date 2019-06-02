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
    
    
    func addTask(_ task: Task) {
        if let user = Auth.auth().currentUser, let dict = task.dictionary {
            ref.child("users/\(user.uid)/tasks").childByAutoId().setValue(dict)
        }
    }
    
    func getListTasks(successBlock: @escaping (([Task]) -> ())) {
        if let user = Auth.auth().currentUser {
            ref.child("users/\(user.uid)/tasks").observe(DataEventType.value, with: { (snapshot) in
                var tasksArray = [Task]()
                for child in snapshot.children {
                    if let child = child as? DataSnapshot , let dict = child.value as? [String : Any] {
                        let task = Task.object(dict)
                        tasksArray.append(task)
                    }
                }
                successBlock(tasksArray)
            })
        }
    }
}
