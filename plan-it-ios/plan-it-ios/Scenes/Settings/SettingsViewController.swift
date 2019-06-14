//
//  SettingsViewController.swift
//  plan-it-ios
//
//  Created by Kirill Philipov on 6/2/19.
//

import UIKit

class SettingsViewController: UIViewController {
    static func storyboardController() -> SettingsViewController {
        let storyboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! SettingsViewController
        return vc
    }
    
    
    @IBOutlet var viewHandler: SettingsViewHandler!
    private var interactor = SettingsInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    private func initialSetup() {
        self.viewHandler.tableView.tableFooterView = UIView()
        self.viewHandler.setUserInfo()
    }
    
    func logOut() {
        PIHaptic.light()
        self.interactor.logOut()
        let vc = RootViewController.storyboardController()
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .fade
        self.hero.replaceViewController(with: vc)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            break
        case 1:
            logOut()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
