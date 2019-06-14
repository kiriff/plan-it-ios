//
//  HomeTableViewCell.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var complteButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mapImageView: UIImageView!
    
    func setup(_ task: Task) {
        nameLabel.text = task.name
        descriptionLabel.text = task.description
        if let days = task.daysLeft() {
            switch days {
            case 1: self.deadlineLabel.text = "tomorrow"; self.deadlineLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8974743151)
            case 0: self.deadlineLabel.text = "today"; self.deadlineLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8974743151)
            case 0...: self.deadlineLabel.text = "\(days) days"; self.deadlineLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8974743151)
            case ..<0: self.deadlineLabel.text = "\(days) days"; self.deadlineLabel.textColor = #colorLiteral(red: 0.7595406975, green: 0, blue: 0.2313725501, alpha: 1)
            default:
                break
            }
        } else {
            self.deadlineLabel.text = task.date()
        }
        
        self.dateLabel.text = task.date()
        
        if let priority = task.priority {
            setPriority(priority)
        }
        
        if let category = task.category {
            setCategory(category)
        }
        
        if task.completed {
            complteButton.alpha = 1
            self.deadlineLabel.text = "Completed!"
        } else {
            complteButton.alpha = 0.2
        }
        
        if let address = task.address {
            if address.lat != 0 && address.lon != 0 {
                mapImageView.isHidden = false
            } else {
                mapImageView.isHidden = true
            }
        }
    }

    private func setPriority(_ priority: Priority) {
        priorityLabel.text = " \(priority.name) "
        priorityLabel.backgroundColor = UIColor(hexString: priority.colorHex)
        priorityLabel.textColor = .white
        priorityLabel.rounded()
    }
    
    func setCategory(_ category: Category) {
        categoryLabel.text = " \(category.name) "
        categoryLabel.rounded()
    }
    
    @IBAction func completeButtonPressed(_ sender: UIButton) {
        
    }
}

