//
//  ContactCellTableViewCell.swift
//  TableViewPractice
//
//  Created by Жансая Шакуали on 11.07.2023.
//

import UIKit

class ContactCell: UITableViewCell {
    
    static let reuseID = "ContactCell"
    
    private let contactNameLabel: UILabel = {
        let contactNameLabel = UILabel()
        contactNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contactNameLabel.textColor = .label
        contactNameLabel.adjustsFontSizeToFitWidth = true
        return contactNameLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(contactNameLabel)
        
        NSLayoutConstraint.activate([
            contactNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contactNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            contactNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contactNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    func set(contacts: Contacts) {
        contactNameLabel.text = contacts.contactName
    }
    
}
