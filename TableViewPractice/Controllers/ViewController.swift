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
    var contacts: [Contact] = []
    var filteredContacts: [Contact] = []
    var dataSource: UITableViewDiffableDataSource<Section, Contact>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        configureTableView()
        setLayout()
        configureDataSource()
        configureAddButton()
        configureSearchController()
    }
    func configureTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseID)
    }
    
    func setLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    func configureAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addContactButton))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func showAlertVC() {
            let alertVC = UIAlertController(title: "Add Contact",
                                            message: "Type number phone",
                                            preferredStyle: .alert)
            
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

            let contact = Contact(name: name)
            self.contacts.append(contact)
            self.updateData(on: self.contacts)
        }))
        alertVC.modalPresentationStyle = .automatic
        self.present(alertVC, animated: true)
    }
    
    @objc func addContactButton() {
        showAlertVC()
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, contact) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseID, for: indexPath) as! ContactCell
            cell.set(contacts: contact)
            return cell
        })
    }
    
    func updateData(on contacts: [Contact]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Contact>()
        snapshot.appendSections([.main])
        snapshot.appendItems(contacts)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: ContactCell.reuseID,
                        for: indexPath
                     ) as? ContactCell else {
                       return UITableViewCell()
        }
        let contacts = contacts[indexPath.row]
        cell.set(contacts: contacts)
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
                self.contacts.remove(at: indexPath.row)
                self.updateData(on: self.contacts)
                
                complete(true)
            }
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
                   configuration.performsFirstActionWithFullSwipe = true
                   return configuration
    }
}

extension ViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: contacts)
            return
        }
        filteredContacts = contacts.filter{ $0.name.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredContacts)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: contacts)
    }
}

