//
//  ContactListModel.swift
//  ContactsManager
//
//  Created by Daniel Esteban Alcantara on 31/10/26.
//

import Foundation
import UIKit

struct ContactModel {
    let id = UUID()
    let firstName: String
    let lastName: String
    let phoneNumber: String

    var fullName: String {
        [firstName, lastName].filter { !$0.isEmpty }.joined(separator: " ")
    }
}

/*
var contacts: [ContactModel] = [
    ContactModel(firstName: "Alejandro", lastName: "Ramírez", phoneNumber: "5512345678")
]
 
*/
 
var contacts: [ContactModel] = [
    ContactModel(firstName: "Alejandro", lastName: "Ramírez", phoneNumber: "5512345678"),
    ContactModel(firstName: "Valentina", lastName: "Torres", phoneNumber: "5587654321"),
    ContactModel(firstName: "Sebastián", lastName: "Morales", phoneNumber: "5543218765"),
    ContactModel(firstName: "Camila", lastName: "Herrera", phoneNumber: "5598761234"),
    ContactModel(firstName: "Diego", lastName: "Fernández", phoneNumber: "5534567890"),
    ContactModel(firstName: "Isabella", lastName: "Castro", phoneNumber: "5578901234"),
    ContactModel(firstName: "Mateo", lastName: "Vargas", phoneNumber: "5523456789"),
    ContactModel(firstName: "Renata", lastName: "Mendoza", phoneNumber: "5567894321"),
    ContactModel(firstName: "Daniel", lastName: "Ortega", phoneNumber: "5556789012"),
    ContactModel(firstName: "Sofía", lastName: "Navarro", phoneNumber: "5545671238")
]
 

class ContactListModel {
    private(set) var filterContacts: [ContactModel] = []

    init() {
        filterContacts(with: "")
    }

    func addContact(_ contact: ContactModel) {
        contacts.append(contact)
    }

    func deleteContact(id: UUID) {
        contacts.removeAll { $0.id == id }
    }

    func getNumberOfSection() -> Int {
        1
    }

    func getNumberOfRows(section: Int) -> Int {
        filterContacts.count
    }

    func getContact(index: IndexPath) -> ContactModel {
        filterContacts[index.row]
    }

    func filterContacts(with text: String) {
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if query.isEmpty {
            filterContacts = contacts
        } else {
            filterContacts = contacts.filter {
                $0.firstName.localizedStandardContains(query) ||
                $0.lastName.localizedStandardContains(query) ||
                $0.phoneNumber.localizedStandardContains(query)
            }
        }
    }
}
