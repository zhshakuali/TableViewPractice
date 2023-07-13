//
//  Extentions.swift
//  TableViewPractice
//
//  Created by Жансая Шакуали on 11.07.2023.
//

import UIKit

extension UIViewController {
    func fetchData() -> [Contacts]{
        let contact1 = Contacts(contactName: "Zhansaya Shakuali")
        let contact2 = Contacts(contactName: "Nodir")
        return [contact1, contact2]
    }
}
