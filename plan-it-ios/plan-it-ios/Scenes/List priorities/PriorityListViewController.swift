//
//  PriorityListViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/5/19.
//

import UIKit

class PriorityListInteractor: NSObject {
    let priorities = [Priority(name: "Low Priority", index: 0, colorHex: "87CEFA"),
                      Priority(name: "Deadline", index: 1, colorHex: "FFD700"),
                      Priority(name: "In progress", index: 2, colorHex: "fce14b"),
                      Priority(name: "Important", index: 3, colorHex: "FFB6C1"),
                      Priority(name: "Critical", index: 4, colorHex: "ff3b00")
                      ]
}

class PriorityListViewController: UIViewController {
    
    static func storyboardController(completion: ((Priority) -> ())? = nil) -> PriorityListViewController {
        let storyboard = UIStoryboard(name: "PriorityListViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! PriorityListViewController
        vc.completion = completion
        return vc
    }
    
    var completion: ((Priority) -> ())? = nil
    let interactor = PriorityListInteractor()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension PriorityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.priorities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "priorityCell", for: indexPath) as! PriorityTableViewCell
        cell.set(self.interactor.priorities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.completion?(self.interactor.priorities[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
