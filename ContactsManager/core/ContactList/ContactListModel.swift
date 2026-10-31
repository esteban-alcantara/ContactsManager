import Foundation
import UIKit

// Conserva la lista completa; buscar nunca modifica los contactos originales.
class ContactListModel {
    private(set) var contacts: [ContactModel] = []
    private(set) var filterContacts: [ContactModel] = []

    init() {
        let initialContacts = [
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
        initialContacts.forEach { addContact($0) }
        filterContacts(with: "")
    }

    func addContact(_ contact: ContactModel) {
        contacts.append(contact)
        contacts.sort {
            let firstNameOrder = $0.firstName.localizedCaseInsensitiveCompare($1.firstName)
            if firstNameOrder == .orderedSame {
                return $0.lastName.localizedCaseInsensitiveCompare($1.lastName) == .orderedAscending
            }
            return firstNameOrder == .orderedAscending
        }
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
