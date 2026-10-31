//
//  CongtactFormModel.swift
//  ContactsManager
//
//  Created by Daniel Esteban Alcantara on 31/10/26.
//

import Foundation

struct ContactFormModel {
    enum ValidationError: LocalizedError {
        case missingFirstName
        case missingPhoneNumber

        var errorDescription: String? {
            switch self {
            case .missingFirstName: return "Enter a first name."
            case .missingPhoneNumber: return "Enter a phone number."
            }
        }
    }

    func createContact(firstName: String, lastName: String, phoneNumber: String) throws -> ContactModel {
        let firstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNumber = phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !firstName.isEmpty else { throw ValidationError.missingFirstName }
        guard !phoneNumber.isEmpty else { throw ValidationError.missingPhoneNumber }
        return ContactModel(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
    }
}
