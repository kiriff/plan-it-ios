//
//  Task.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import Foundation

struct Task: Codable {
    var name: String
    var description: String?
    var priority: Priority?
    var completed: Bool
    var deadline: Double?
    var category: Category?
}

struct Category: Codable {
    var id: Int
    var name: String
}

struct Priority: Codable {
    var name: String
    var index: Int
}

extension Task {
    static func object(_ dict: [String : Any]) -> Task {
        let name = dict["name"] as? String ?? ""
        let description = dict["description"] as? String
        let completed = dict["completed"] as? Bool ?? false
        let deadline = dict["deadline"] as? Double
        
        let priorityDict = dict["priority"] as? [String : Any]
        let pindex = priorityDict?["index"] as? Int ?? 0
        let pname = priorityDict?["name"] as? String ?? ""
        
        let categoryDict = dict["category"] as? [String : Any]
        let cid = categoryDict?["id"] as? Int ?? 0
        let cname = categoryDict?["name"] as? String ?? ""
        
        let task = Task(name: name, description: description, priority: Priority(name: pname, index: pindex), completed: completed, deadline: deadline, category: Category(id: cid, name: cname))
        return task
    }
}
