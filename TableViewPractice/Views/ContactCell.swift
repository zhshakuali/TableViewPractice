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
        
        let topBottomOffset: CGFloat = 10
        let sideOffset: CGFloat = 20
        
        contentView.addSubview(contactNameLabel)
        
        NSLayoutConstraint.activate([
            contactNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topBottomOffset),
            contactNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -topBottomOffset),
            contactNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sideOffset),
            contactNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -sideOffset)
        ])
    }
    
    func set(contacts: Contact) {
        contactNameLabel.text = contacts.name
    }
    
}
