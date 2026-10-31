import UIKit

class ContactListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private let model = ContactListModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(addContact)
        )
        searchBar.delegate = self
        setUpTableView()
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
        model.filterContacts(with: searchBar.text ?? "")
        tableView.reloadData()
        updateEmptyState()
    }

    private func updateEmptyState() {
        guard model.filterContacts.isEmpty else {
            tableView.backgroundView = nil
            return
        }
        let message = UILabel()
        message.text = model.contacts.isEmpty
            ? "No contacts yet.\nTap + to add your first contact."
            : "No matching contacts.\nTry another name or phone number."
        message.textAlignment = .center
        message.numberOfLines = 0
        message.font = .preferredFont(forTextStyle: .body)
        message.adjustsFontForContentSizeCategory = true
        message.textColor = .secondaryLabel
        tableView.backgroundView = message
    }

    @objc private func addContact() {
        view.endEditing(true)
        let controller = ContactFormViewController()
        controller.delegate = self
        present(UINavigationController(rootViewController: controller), animated: true)
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
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Capturamos el contacto, no la posición en una lista que puede estar filtrada.
        let contact = model.getContact(index: indexPath)
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            completion(false)
            guard let self else { return }
            let alert = UIAlertController(
                title: "Delete contact?",
                message: "Delete \(contact.fullName)?",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                self?.model.deleteContact(id: contact.id)
                self?.updateContacts()
            })
            self.present(alert, animated: true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

extension ContactListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.filterContacts(with: searchText)
        tableView.reloadData()
        updateEmptyState()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ContactListViewController: ContactFormViewControllerDelegate {
    func contactFormViewController(_ controller: ContactFormViewController, didSave contact: ContactModel) {
        model.addContact(contact)
        searchBar.text = ""
        updateContacts()
        controller.dismiss(animated: true)
    }
}
