//
//  SettingsViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var viewHandler: SettingsViewHandler!
    private var interactor = SettingsInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.interactor.settingsTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.interactor.cellID, for: indexPath) as! SettingsTableViewCell
        cell.setup(self.interactor.settingsTitles[indexPath.row])
        return cell
    }
    
    
}
