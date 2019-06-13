//
//  TaskDetailsViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/5/19.
//

import UIKit
import FSCalendar

class TaskDetailsViewController: UIViewController {

    static func storyboardController(task: Task, completion: ((Task) -> ())? = nil) -> TaskDetailsViewController {
        let storyboard = UIStoryboard(name: "TaskDetailsViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! TaskDetailsViewController
        vc.task = task
        vc.completion = completion
        return vc
    }
    
    var completion: ((Task) -> ())? = nil
    var task: Task!
    var isDeleted = false
    @IBOutlet var viewHandler: TaskDetailsViewHandler!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if !isDeleted {
            task.description = self.viewHandler.descriptionTextField.text
            self.completion?(task)
        }
    }

    func initialSetup() {
        self.viewHandler.calendar.delegate = self
        self.viewHandler.setupTaskDetails(task)
        self.viewHandler.initialSetup()
    }
    
    @IBAction func nameDidEnd(_ sender: UITextField) {
        if sender.text!.isEmpty {
            task.name = "Task name"
        } else {
            task.name = sender.text!
        }
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        APIManager.shared.removeTask(task)
        self.isDeleted = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func markAsDonePressed(_ sender: UIButton) {
        task.completed.toggle()
    }
    
    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        let vc = CategoryListViewController.storyboardController { (category) in
            self.task.category = category
            self.viewHandler.setupCategoryButton(category)
        }
        self.storkPresent(vc, swipe: true, height: self.safeAreaHeight - 100)
    }
    
    @IBAction func priorityButtonPressed(_ sender: UIButton) {
        let vc = PriorityListViewController.storyboardController { (priority) in
            self.task.priority = priority
            self.viewHandler.setupPriorityButton(priority)
        }
        self.storkPresent(vc, swipe: true, height: self.safeAreaHeight - 100)
    }
}

extension TaskDetailsViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.task.deadline = date.timeIntervalSince1970
    }
}
