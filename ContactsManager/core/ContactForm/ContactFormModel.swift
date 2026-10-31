//
//  CongtactFormModel.swift
//  ContactsManager
//
//  Created by Daniel Esteban Alcantara on 31/10/26.
//

import Foundation

struct ContactFormModel {
    func createContact(firstName: String, lastName: String, phoneNumber: String) -> ContactModel {
        return ContactModel(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
    }
}
