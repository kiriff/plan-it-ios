//
//  HomeViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit
import FirebaseAuth
import Hero

class HomeViewController: UIViewController {
    
    @IBOutlet private var viewHandler: HomeViewHandler!
    private let interactor = HomeInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func initialSetup() {
        HUD.show()
        self.interactor.getTasks {
            self.viewHandler.tableView.reloadData()
            HUD.hide()
        }
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        self.storkPresent(SettingsViewController.storyboardController(), swipe: true, height: self.safeAreaHeight - 50)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.interactor.cellID, for: indexPath) as! HomeTableViewCell
        cell.setup(self.interactor.tasks[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}
