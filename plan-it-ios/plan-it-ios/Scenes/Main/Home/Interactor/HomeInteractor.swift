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
    
    func getTasks(completion: @escaping () -> ()) {
        APIManager.shared.getListTasks { (tasks) in
            self.tasks = tasks
            completion()
        }
    }
    
}
