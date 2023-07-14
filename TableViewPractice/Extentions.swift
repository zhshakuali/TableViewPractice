//
//  Extentions.swift
//  TableViewPractice
//
//  Created by Жансая Шакуали on 11.07.2023.
//

import UIKit

extension UIViewController {
    func fetchData() -> [Contact]{
        let contact1 = Contact(name: "Zhansaya Shakuali")
        let contact2 = Contact(name: "Nodir")
        return [contact1, contact2]
    }
}
