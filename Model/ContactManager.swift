//
//  ContactManager.swift
//  iPlanner
//
//  Created by Сергей Петров on 06.08.2021.
//

import Foundation
import Contacts

class ContactManager {
    
    public static var shared = ContactManager()
    
    private init() {
        
    }
    
    func getContactInfo(contact: Contact) -> (identifier: String, fullName: String) {
        var givenName = ""
        var middleName = ""
        var familyName = ""
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("ContactManager error!: \(error.localizedDescription)")
            }
            if granted {
                let keys = [CNContactIdentifierKey, CNContactGivenNameKey, CNContactFamilyNameKey, CNContactMiddleNameKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request) { (currentContact, stopPointer) in
                        if contact.identifier == currentContact.identifier {
                            givenName = currentContact.givenName
                            middleName = currentContact.middleName
                            familyName = currentContact.familyName
                        }
                    }
                } catch {
                    print("failed to parse contacts! Description: \(error.localizedDescription)")
                }
            } else {
                print("ContactManager error! Access denied!")
            }
        }
        return (identifier: contact.identifier, fullName: givenName + " " + middleName + " " + familyName)
    }
    
    func getContacts() -> [Contact] {
        var contacts: [Contact] = []
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to access contacts! Description: \(error.localizedDescription)")
                return
            }
            if granted {
                let keys = [CNContactIdentifierKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request) { (contact, stopPointer) in
                        let newContact = Contact(identifier: contact.identifier, actions: nil)
                        contacts.append(newContact)
                    }
                } catch let error {
                    print("failed to parse contacts! Description: \(error.localizedDescription)")
                }
            } else {
                print("access denied!")
            }
        }
        return contacts
    }
}
