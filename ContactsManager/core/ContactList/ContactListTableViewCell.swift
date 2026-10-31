import UIKit

class ContactListTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ContactCell"

    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        contactImageView.image = UIImage(systemName: "person.crop.circle.fill")
        contactImageView.tintColor = .systemBlue
        nameLabel.adjustsFontForContentSizeCategory = true
        phoneLabel.adjustsFontForContentSizeCategory = true
        phoneLabel.textColor = .secondaryLabel
    }

    func configuration(with contact: ContactModel) {
        nameLabel.text = contact.fullName
        phoneLabel.text = contact.phoneNumber
    }
}
