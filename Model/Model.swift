//
//  Model.swift
//  iPlanner
//
//  Created by Сергей Петров on 29.07.2021.
//

import Foundation
import Contacts

struct TestUserContact {
    var firstname: String
    var secondName: String
    var company: String

    var count: Int {
        return firstname.count + secondName.count + company.count
    }
    var fullName: String {
        return firstname + " " + secondName
    }
}

protocol UserContent {
    var identifier: String { get set }
}

struct UserContact: UserContent {
    var identifier: String
    var contact: CNContact?
    var actions: [UserAction]?
    
    var fullName: String {
        return (contact?.givenName ?? "") + (contact?.middleName ?? " ") + (contact?.familyName ?? "")
    }
}

struct UserActionType: UserContent {
    var identifier: String
    var typeName: String
    var actions: [UserAction]?
}

struct UserAction: UserContent {
    var identifier: String
    var description: String?
    var actionType: UserActionType
    var owner: UserContact
}
