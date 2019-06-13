//
//  TaskDetailsViewHandler.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/5/19.
//

import UIKit
import FSCalendar

class TaskDetailsViewHandler: NSObject {
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var priorityButton: UIButton!
    @IBOutlet weak var markAsDoneButton: UIButton!
    @IBOutlet weak var deleteTaskButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var textViewShadowView: UIView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var addressLabel: UILabel!
    
    func setupTaskDetails(_ task: Task) {
        nameTextField.text = task.name
        descriptionTextField.text = task.description
        categoryButton.setTitle(task.category?.name, for: .normal)
        priorityButton.setTitle(task.priority?.name, for: .normal)
        setupPriorityButton(task.priority)
        if let deadline = task.deadline {
            calendar.select(Date(timeIntervalSince1970: deadline), scrollToDate: true)
        }
        if let address = task.address {
            addressLabel.text = address.name
        }
    }
    
    func setupPriorityButton(_ priority: Priority?) {
        guard let priority = priority else { return }
        priorityButton.backgroundColor = UIColor.init(hexString: priority.colorHex)
        priorityButton.setTitle(priority.name, for: .normal)
    }
    
    func setupCategoryButton(_ category: Category?) {
        guard let category = category else { return }
        categoryButton.setTitle(category.name, for: .normal)
    }
    
    func initialSetup() {
        textViewShadowView.makeShadow()
        calendar.makeShadow()
    }
}
