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
    var newContacts: [Contacts] = []
    
    var dataSource: UITableViewDiffableDataSource<Section, Contacts>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        configureTableView()
        contacts = fetchData()
        configureSearchController()
        configureDataSource()
        configureAddButton()
    }
    func configureTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isEditing = true
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
        showAlertVC()
    }
    
    //add addingFunction
    //add remove func
    //add sections
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
    
    //add update func
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, contact) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseID, for: indexPath) as! ContactCell
            cell.set(contacts: contact)
            return cell
        })
    }
    
    
    func updateData(on contacts: [Contacts]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Contacts>()
        snapshot.appendSections([.main])
        snapshot.appendItems(contacts)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    func showAlertVC() {
            let alertVC = UIAlertController(title: "Add Contact", message: "Type number phone", preferredStyle: .alert)
            
            alertVC.addTextField { field in
                field.placeholder = "Type name"
                field.returnKeyType = .next
                field.keyboardType = .default
            }
            
            alertVC.addTextField { field in
                field.placeholder = "Type number"
                field.returnKeyType = .done
                field.keyboardType = .namePhonePad
            }
            
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Add contact", style: .default, handler: { _ in
            guard let fields = alertVC.textFields, fields.count == 2 else { return }
            let contactName = fields[0]
            let contactNumber = fields[1]
            
            guard let name = contactName.text, !name.isEmpty,
                  let number = contactNumber.text, !number.isEmpty else {
                print("Invalid adding")
                return
            }
            
            print("Name: \(name)")
            print("Number: \(number)")

            let contact = Contacts(contactName: name)
            self.contacts.append(contact)
            self.updateData(on: self.contacts)
        }))
    
        alertVC.modalPresentationStyle = .automatic
        self.present(alertVC, animated: true)
        
    }
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
}

extension ViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        filteredContacts = contacts.filter{ $0.contactName.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredContacts)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: contacts)
    }
}

