//
//  CategoryListViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/13/19.
//

import UIKit

class CategoryListInteractor: NSObject {
    let categories = [Category(id: 0, name: "Don't forget"),
                      Category(id: 1, name: "Personal"),
                      Category(id: 2, name: "Social"),
                      Category(id: 3, name: "Family"),
                      Category(id: 4, name: "Work"),
                      Category(id: 5, name: "Birthday")]
}

class CategoryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static func storyboardController(completion: ((Category) -> ())? = nil) -> CategoryListViewController {
        let storyboard = UIStoryboard(name: "CategoryListViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! CategoryListViewController
        vc.completion = completion
        return vc
    }
    
    var completion: ((Category) -> ())? = nil
    let interactor = CategoryListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension CategoryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
        cell.setCategory(self.interactor.categories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.completion?(self.interactor.categories[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
