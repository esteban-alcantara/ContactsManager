//
//  ContactFormView.swift
//  ContactsManager
//
//  Created by Daniel Esteban Alcantara on 31/10/26.
//

import UIKit

// Esta vista sólo presenta los campos. La validación está en ContactFormModel.
class ContactFormView: UIView {
    
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let phoneNumberTextField = UITextField()
    let saveButton = UIButton(type: .system)
    let cancelButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }

    private func setUpView() {
        backgroundColor = .systemBackground
        
        saveButton.configuration = .filled()
        saveButton.configuration?.title = "Save"
        saveButton.configuration?.cornerStyle = .capsule
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(saveButton)

        cancelButton.configuration = .plain()
        cancelButton.configuration?.title = "Cancel"
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancelButton)

        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stack)

        configure(firstNameTextField, title: "First name", contentType: .givenName, in: stack)
        configure(lastNameTextField, title: "Last name", contentType: .familyName, in: stack)
        configure(phoneNumberTextField, title: "Phone number", contentType: .telephoneNumber, in: stack)
        
        phoneNumberTextField.keyboardType = .phonePad
        firstNameTextField.returnKeyType = .next
        lastNameTextField.returnKeyType = .next

        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            cancelButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            cancelButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            cancelButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            
            saveButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -12),
            saveButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            saveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            saveButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -16),
            
            stack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -24),
            stack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40)
        ])
    }

    private func configure(_ textField: UITextField, title: String,
                           contentType: UITextContentType, in stack: UIStackView) {
        let label = UILabel()
        label.text = title
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .body)
        textField.adjustsFontForContentSizeCategory = true
        textField.textContentType = contentType
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.accessibilityLabel = title
        textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        
        let fieldStack = UIStackView(arrangedSubviews: [label, textField])
        fieldStack.axis = .vertical
        fieldStack.spacing = 8
        stack.addArrangedSubview(fieldStack)
    }
}
