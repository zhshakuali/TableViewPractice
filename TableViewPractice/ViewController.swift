//
//  ViewController.swift
//  TableViewPractice
//
//  Created by Жансая Шакуали on 11.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    enum Section { case main }
    
    var tableView: UITableView!
    var contacts: [Contacts] = []
    var filteredContacts: [Contacts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        configureTableView()
        contacts = fetchData()
        configureSearchController()
        configureAddButton()
    }
    func configureTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.allowsSelection = false
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseID)
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    func configureAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactButton))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addContactButton() {
        
    }
    
    func addingContacts() {
        
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
    }
    
//    func updateData(on followers: [Contacts]) {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Contacts>()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(followers)
//        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
//    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseID) as! ContactCell
        let contacts = contacts[indexPath.row]
        cell.set(contacts: contacts)

        return cell
    }
}

extension ViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filteredContacts = contacts.filter{ $0.contactName.lowercased().contains(filter.lowercased()) }
//        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        updateData(on: followers)
    }
}

