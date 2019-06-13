//
//  Task.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import Foundation

struct Task: Codable {
    var id: String
    var name: String
    var description: String?
    var priority: Priority?
    var completed: Bool
    var deadline: Double?
    var category: Category?
    var address: Address?
}

struct Address: Codable {
    var name: String
    var lat: Double
    var lon: Double
}

struct Category: Codable {
    var id: Int
    var name: String
}

struct Priority: Codable {
    var name: String
    var index: Int
    var colorHex: String
}

extension Priority {
    static func defaultPriority() -> Priority {
        return Priority(name: "Low Priority", index: 0, colorHex: "5785f2")
    }
}

extension Category {
    static func defaultCategory() -> Category {
        return Category(id: 1, name: "Personal")
    }
}

extension Task {
    static func object(_ dict: [String : Any]) -> Task {
        let id = dict["id"] as? String ?? ""
        let name = dict["name"] as? String ?? ""
        let description = dict["description"] as? String
        let completed = dict["completed"] as? Bool ?? false
        let deadline = dict["deadline"] as? Double
        
        let priorityDict = dict["priority"] as? [String : Any]
        let pindex = priorityDict?["index"] as? Int ?? 0
        let pname = priorityDict?["name"] as? String ?? ""
        let pcolorHex = priorityDict?["colorHex"] as? String ?? ""
        
        let categoryDict = dict["category"] as? [String : Any]
        let cid = categoryDict?["id"] as? Int ?? 0
        let cname = categoryDict?["name"] as? String ?? ""
        
        let addressDict = dict["address"] as? [String : Any]
        let aname = addressDict?["name"] as? String ?? ""
        let alat = addressDict?["lat"] as? Double ?? 0
        let alon = addressDict?["lon"] as? Double ?? 0
        
        let task = Task(id: id, name: name, description: description, priority: Priority(name: pname, index: pindex, colorHex: pcolorHex), completed: completed, deadline: deadline, category: Category(id: cid, name: cname), address: Address(name: aname, lat: alat, lon: alon))
        return task
    }
}
