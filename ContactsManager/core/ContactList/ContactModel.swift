import Foundation

struct ContactModel {
    let id = UUID()
    let firstName: String
    let lastName: String
    let phoneNumber: String

    var fullName: String {
        [firstName, lastName].filter { !$0.isEmpty }.joined(separator: " ")
    }
}
