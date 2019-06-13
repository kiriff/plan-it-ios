//
//  HomeInteractor.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit

class HomeInteractor: NSObject {
    
    let cellID = "taskCell"
    var tasks: [Task] = []
    var filteredTasks: [Task] = []
    
    func getTasks(completion: @escaping () -> ()) {
        APIManager.shared.getListTasks { (tasks) in
            self.tasks = tasks.reversed()
            completion()
        }
    }
    
    func updateTask(_ task: Task, completion: @escaping () -> ()) {
        APIManager.shared.updateTask(task)
    }
    
    func filterTasks(_ text: String, completion: @escaping () -> ()) {
        filteredTasks = tasks.filter({ $0.name.lowercased().contains(text.lowercased())} )
        completion()
    }
}
