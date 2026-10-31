//
//  ContactListViewController.swift
//  ContactsManager
//
//  Created by Daniel Esteban Alcantara on 31/10/26.
//


import UIKit

class ContactListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private let model = ContactListModel()
    private var contactCountBeforeForm: Int?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Contacts"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(addContact)
        )
        
        searchBar.delegate = self
        setUpTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let previousCount = contactCountBeforeForm, contacts.count > previousCount {
            searchBar.text = ""
        }
        contactCountBeforeForm = nil
        updateContacts()
    }

    private func setUpTableView() {
        let nib = UINib(nibName: "ContactListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ContactListTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
    }

    private func updateContacts() {
        orderContects()
        model.filterContacts(with: searchBar.text ?? "")
        tableView.reloadData()
        updateEmptyContacts()
    }

    private func updateEmptyContacts() {
        guard model.filterContacts.isEmpty else {
            tableView.backgroundView = nil
            return
        }
        let message = UILabel()
        message.text = contacts.isEmpty
            ? "No contacts yet.\nTap + to add a contact."
            : "No matching contacts.\nTry another name or phone number."
        message.textAlignment = .center
        message.numberOfLines = 0
        message.font = .preferredFont(forTextStyle: .body)
        message.adjustsFontForContentSizeCategory = true
        message.textColor = .secondaryLabel
        tableView.backgroundView = message
    }

    private func showDeleteAlert(at indexPath: IndexPath, completion: @escaping (Bool) -> Void) {
        let contact = model.getContact(index: indexPath)
        let alert = UIAlertController(
            title: "Delete contact?",
            message: "Delete \(contact.fullName)?",
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(false)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            guard let self else {
                completion(false)
                return
            }
            
            guard let row = self.model.filterContacts.firstIndex(where: { $0.id == contact.id }) else {
                completion(false)
                return
            }
            self.model.deleteContact(id: contact.id)
            self.model.filterContacts(with: self.searchBar.text ?? "")
            self.tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
            self.updateEmptyContacts()
            completion(true)
        }

        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true)
    }
    
    private func orderContects() {
        contacts.sort {
            $0.fullName.localizedCaseInsensitiveCompare($1.fullName) == .orderedAscending
        }
    }

    @objc private func addContact() {
        view.endEditing(true)
        let ContactFormViewController = ContactFormViewController()
        contactCountBeforeForm = contacts.count
        navigationController?.pushViewController(ContactFormViewController, animated: true)
    }
}

extension ContactListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        model.getNumberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.getNumberOfRows(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ContactListTableViewCell.reuseIdentifier, for: indexPath
        ) as? ContactListTableViewCell else { return UITableViewCell() }
        cell.configuration(with: model.getContact(index: indexPath))
        return cell
    }
}

extension ContactListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteContact = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            guard let self else {
                completion(false)
                return
            }
            self.showDeleteAlert(at: indexPath, completion: completion)
        }
        deleteContact.image = UIImage(systemName: "trash")

        let configuration = UISwipeActionsConfiguration(actions: [deleteContact])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}

extension ContactListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.filterContacts(with: searchText)
        tableView.reloadData()
        updateEmptyContacts()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
