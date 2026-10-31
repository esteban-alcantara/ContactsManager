import UIKit

protocol ContactFormViewControllerDelegate: AnyObject {
    func contactFormViewController(_ controller: ContactFormViewController, didSave contact: ContactModel)
}

class ContactFormViewController: UIViewController {
    weak var delegate: ContactFormViewControllerDelegate?
    private let model = ContactFormModel()
    private let formView = ContactFormView()

    override func loadView() {
        view = formView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Contact"
        isModalInPresentation = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel, target: self, action: #selector(cancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self, action: #selector(save)
        )
        formView.firstNameTextField.delegate = self
        formView.lastNameTextField.delegate = self
    }

    @objc private func cancel() {
        dismiss(animated: true)
    }

    @objc private func save() {
        do {
            let contact = try model.createContact(
                firstName: formView.firstNameTextField.text ?? "",
                lastName: formView.lastNameTextField.text ?? "",
                phoneNumber: formView.phoneNumberTextField.text ?? ""
            )
            delegate?.contactFormViewController(self, didSave: contact)
        } catch {
            let alert = UIAlertController(title: "Check your contact", message: error.localizedDescription,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
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
