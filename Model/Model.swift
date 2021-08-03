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
    var givenName: String?
    var middleName: String?
    var familyName: String?
    var jobTitle: String?
    var nickName: String?
    var actions: [UserAction]?
    
    var fullName: String {
        return "\(givenName ?? "") \(middleName ?? " ") \(familyName ?? "")"
//        print("given: \(givenName ?? "!"), middle: \(middleName ?? "!"), family: \(familyName ?? "!")")
//        return (givenName ?? " ") + (middleName ?? " ") + (familyName ?? " ")
    }
}

struct UserActionType: UserContent {
    var identifier: String
    var typeName: String
    var actions: [UserAction]?
}

struct UserAction: UserContent {
    var identifier: String
    var actionDescription: String?
    var createDate: Date
    var finishDate: Date?
    var actionType: UserActionType
    var owner: UserContact
}

//struct UserContactDetail: UserContent {
//    var identifier: String
//    var givenName: String?
//    var middleName: String?
//    var familyName: String?
//    var jobTitle: String?
//    var nickName: String?
//
//    var fullName: String {
//        return (givenName ?? "") + (middleName ?? " ") + (familyName ?? "")
//    }
//}
