//
//  ContactFormViewController.swift
//  ContactsManager
//
//  Created by Daniel Esteban Alcantara on 31/10/26.
//


import UIKit

class ContactFormViewController: UIViewController {
    
    private let model = ContactFormModel()
    private let formView = ContactFormView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = formView
        title = "New Contact"
        formView.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        formView.saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        formView.firstNameTextField.delegate = self
        formView.lastNameTextField.delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    


    @objc private func hideKeyboard(_ gesture: UITapGestureRecognizer) {
        let fields = [formView.firstNameTextField, formView.lastNameTextField, formView.phoneNumberTextField]
        for field in fields {
            if field.bounds.contains(gesture.location(in: field)) {
                return
            }
        }
        view.endEditing(true)
    }

    @objc private func cancel() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func save() {
        
        let firstName = (formView.firstNameTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = (formView.lastNameTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNumber = (formView.phoneNumberTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        if firstName.isEmpty {
            showValidationAlert(message: "Enter a first name.")
            return
        }

        if phoneNumber.isEmpty {
            showValidationAlert(message: "Enter a phone number.")
            return
        }

        let contact = model.createContact(
            firstName: firstName,
            lastName: lastName,
            phoneNumber: phoneNumber
        )
        ContactListModel().addContact(contact)
        
        navigationController?.popViewController(animated: true)
    }

    private func showValidationAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}

extension ContactFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === formView.firstNameTextField {
            formView.lastNameTextField.becomeFirstResponder()
        } else {
            formView.phoneNumberTextField.becomeFirstResponder()
        }
        return true
    }
}
