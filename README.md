
# Contacts Manager

**iOS Development Assignment | Swift + UIKit**

---

## User Story

As a user, I want to create, search, and delete contacts so that I can organize contact information and quickly find the people I need.

## Objective

Build an iOS application inspired by the iPhone Contacts app. Include a contact list and a form for adding contacts. An exact visual replica is not required; focus on table views, data entry, filtering, and deletion.

### 1. Contact List

- Use **Contacts** as the screen title. Display contacts in a `UITableView` with one section and no section headers.
- Each custom cell must display the contact's full name, phone number, and a generic image from SF Symbols. A real contact photo is not required.
- Include a **+** button to open the contact form and a `UISearchBar` to search the list. No contact detail screen is required.
- Support an empty list. Display a helpful message when no contacts exist and a different message when a search has no matches.

### 2. Add Contact Form

- Present a separate form screen with fields for first name, last name, and phone number, plus **Save** and **Cancel** actions. You may present it modally or use push navigation.
- First name and phone number are required; last name is optional. Remove leading and trailing whitespace. Reject required fields that are empty or contain only whitespace, and display a clear validation message. Advanced phone-number validation is not required.
- On **Save**, add the contact, close the form, clear the current search, and update the table immediately. Keep contacts in alphabetical order by first name, then last name, ignoring case.
- **Cancel** must close the form without adding a contact.

### 3. Search Contacts

- Filter the list as the user types. Match text appearing anywhere in the first name, last name, or phone number. Text searches must ignore uppercase and lowercase differences.
- Ignore leading and trailing whitespace in the query. An empty or whitespace-only search must display all contacts.
- Searching must preserve the complete list and the alphabetical order of matching contacts.

### 4. Delete Contacts

- Swiping a row to the left must reveal a **Delete** action. Before removing a contact, show an alert with the contact's name and **Cancel** and **Delete** options.
- **Cancel** must preserve the contact. Confirming must remove the selected contact and update the table immediately.

---

## Requirements & Evaluation

### Technical Requirements

- **Use MVC (Model-View-Controller):** models represent and manage data, views handle presentation, and view controllers coordinate user actions and screen updates. Organize the code by these responsibilities.
- **Configure the initial screen explicitly in `SceneDelegate`** using `scene(_:willConnectTo:options:)`. Set up the window and its root view controller there, including a navigation controller where needed. Use a different initial storyboard, a XIB, or a programmatic screen instead of `Main.storyboard`; remove any automatic Main storyboard startup configuration.
- **Xcode is mandatory.** Create, build, and run the application as an iOS project in Xcode. Submissions created exclusively with another editor or development environment do not meet this requirement.
- Use **Swift and UIKit**, `UITableView` for the list, `UISearchBar` for filtering, and a `UITableViewCell` subclass for custom cells.
- Define a contact model using a Swift structure or class, including first name, last name, and phone number. Contacts may have the same name.
- Use Auto Layout. Storyboards, XIB files, programmatic UIKit, or a combination of these approaches are acceptable.
- Keep contacts in memory while the app is running. **Persistence is not required:** the list may reset when the app is relaunched. Access to the device's real contacts, external APIs, calling, and photo selection are not required.
