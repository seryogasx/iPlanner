//
//  Model.swift
//  iPlanner
//
//  Created by Сергей Петров on 29.07.2021.
//

import Foundation
import Contacts
import CoreData

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

public class UserContent: NSManagedObject {
    
}

extension UserContent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserContent> {
        return NSFetchRequest<UserContent>(entityName: "UserContent")
    }

    @NSManaged public var identifier: String

}

public class UserAction: UserContent {

}

extension UserAction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAction> {
        return NSFetchRequest<UserAction>(entityName: "UserAction")
    }

    @NSManaged public var actionDescription: String?
    @NSManaged public var createDate: Date
    @NSManaged public var finishDate: Date?
    @NSManaged public var actionType: UserActionType
    @NSManaged public var owner: UserContact

}

public class UserActionType: UserContent {
    
}

extension UserActionType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserActionType> {
        return NSFetchRequest<UserActionType>(entityName: "UserActionType")
    }
    
    @NSManaged public var typeName: String
    @NSManaged public var actions: NSSet?

}

// MARK: Generated accessors for actions
extension UserActionType {

    @objc(addActionsObject:)
    @NSManaged public func addToActions(_ value: UserAction)

    @objc(removeActionsObject:)
    @NSManaged public func removeFromActions(_ value: UserAction)

    @objc(addActions:)
    @NSManaged public func addToActions(_ values: NSSet)

    @objc(removeActions:)
    @NSManaged public func removeFromActions(_ values: NSSet)

}

public class UserContact: UserContent {
    
}

extension UserContact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserContact> {
        return NSFetchRequest<UserContact>(entityName: "UserContact")
    }

//    @NSManaged public var familyName: String?
//    @NSManaged public var givenname: String?
//    @NSManaged public var jobTitle: String?
//    @NSManaged public var middleName: String?
//    @NSManaged public var nickName: String?
//    @NSManaged public var actions: NSSet?

//    var fullName: String {
//        return (givenname ?? "") + (middleName ?? "") + (familyName ?? "")
//    }
}

// MARK: Generated accessors for actions
extension UserContact {

    @objc(addActionsObject:)
    @NSManaged public func addToActions(_ value: UserAction)

    @objc(removeActionsObject:)
    @NSManaged public func removeFromActions(_ value: UserAction)

    @objc(addActions:)
    @NSManaged public func addToActions(_ values: NSSet)

    @objc(removeActions:)
    @NSManaged public func removeFromActions(_ values: NSSet)

}

protocol Content {
    var identifier: String { get set }
}

struct ActionType: Content {
    var typeName: String
    var identifier: String
    var actions: [Action]?
}

struct Action: Content {
    var identifier: String
    var actionDescription: String
    var createDate: Date
    var finishDate: Date?
    var owner: Contact
    var actionType: ActionType
}

struct Contact: Content {
    var identifier: String
    var actions: [Action]?
}
