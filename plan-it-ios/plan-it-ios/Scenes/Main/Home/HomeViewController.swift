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
    private var searchController: UISearchController!
    
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
        self.setupSearchController()
    }
    
    func createTask(_ text: String) {
        let task = Task(id: "", name: text, description: "", priority: Priority.defaultPriority(), completed: false, deadline: Date().timeIntervalSince1970, category: Category.defaultCategory(), address: nil)
        print(task.dictionary!)
        APIManager.shared.addTask(task)
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: UITextField) {
        if !sender.text!.isEmpty {
            createTask(sender.text!)
            sender.text = ""
        }
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        self.storkPresent(SettingsViewController.storyboardController(), swipe: true, height: self.safeAreaHeight - 50)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.interactor.filteredTasks.isEmpty {
            return self.interactor.tasks.count
        } else {
            return self.interactor.filteredTasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.interactor.cellID, for: indexPath) as! HomeTableViewCell
        if self.interactor.filteredTasks.isEmpty {
            cell.setup(self.interactor.tasks[indexPath.row])
        } else {
            cell.setup(self.interactor.filteredTasks[indexPath.row])
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = TaskDetailsViewController.storyboardController(task: self.interactor.tasks[indexPath.row]) { [weak self] (task) in
            self?.interactor.updateTask(task, completion: {
                
            })
        }
        self.storkPresent(vc, swipe: true, height: self.safeAreaHeight - 30)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.alpha = 0.5
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.alpha = 1
        }
    }
}

extension HomeViewController: UISearchResultsUpdating {
    fileprivate func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.backgroundImage = UIImage()
//        searchController.searchBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7834439212)
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.searchBar.showsScopeBar = false
        
        self.viewHandler.tableView.tableHeaderView = searchController.searchBar
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if (searchController.searchBar.text! == "") {
            self.interactor.filteredTasks = []
            self.viewHandler.tableView.reloadData()
        } else {
            self.interactor.filterTasks(searchController.searchBar.text!) {
                self.viewHandler.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
    }
}
