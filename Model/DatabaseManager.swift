//
//  DatabaseManager.swift
//  iPlanner
//
//  Created by Сергей Петров on 01.08.2021.
//

import Foundation
import CoreData

class DatabaseManager {
    
    public var shared = DatabaseManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("NSPersistentContainer error! Failed to load persistent container!: ", error.localizedDescription)
            }
        }
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
//    private init() {}
    
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                print("DatabaseManagerError! Failed to save context!: ", error.localizedDescription)
            }
        }
    }
}


// MARK: UserActionType functions
extension DatabaseManager {
    func addUserActionType(_ actionType: UserActionType) {
//        guard let entity = NSEntityDescription.entity(forEntityName: "UserActionType", in: mainContext) else {
//            return
//        }
//
//        let newActionType = NSManagedObject(entity: entity, insertInto: mainContext)
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserAction")
//        get
    }
    
//    func getUserActionType() -> UserActionType? {
//
//    }
//
//    func getUserActionTypes() -> [UserActionType]? {
//
//    }
}

// MARK: UserAction functions
extension DatabaseManager {
    
    func addUserAction(_ userAction: UserAction) {
        guard let entity = NSEntityDescription.entity(forEntityName: "UserAction", in: mainContext) else { return }
        
        let newAction = NSManagedObject(entity: entity, insertInto: mainContext)
        newAction.setValue(userAction.actionDescription, forKey: "actionDescription")
        newAction.setValue(userAction.identifier, forKey: "identifier")
        newAction.setValue(userAction.createDate, forKey: "createDate")
        if userAction.finishDate != nil {
            newAction.setValue(userAction.finishDate, forKey: "finishDate")
        }
        
        let actionTypeFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserActionType")
        let contactFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserContact")
        actionTypeFetchRequest.predicate = NSPredicate(format: "identifier == %@", userAction.actionType.identifier)
        contactFetchRequest.predicate = NSPredicate(format: "identifier == %@", userAction.owner.identifier)
        
        do {
            let result = try mainContext.fetch(actionTypeFetchRequest)
            guard let actionType = result.first as? NSManagedObject else { return }
            newAction.setValue(actionType, forKey: "actionType")
            
            let result2 = try mainContext.fetch(contactFetchRequest)
            guard let contact = result2.first as? NSManagedObject else { return }
            newAction.setValue(contact, forKey: "owner")
            
            try mainContext.save()
        } catch {
            print("DatabaseManager error! Failed to add userAction!: \(error.localizedDescription)")
        }
    }
    
    func deleteUserAction(_ userAction: UserAction) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserAction")
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", userAction.identifier)
        
        do {
            let result = try mainContext.fetch(fetchRequest)
            guard let action = result.first as? NSManagedObject else { return }
            mainContext.delete(action)
            try mainContext.save()
        } catch {
            print("DatabaseManager error! Failed to delete userAction!: \(error.localizedDescription)")
        }
    }
    
    func updateUserAction(_ userAction: UserAction) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserAction")
        fetchRequest.predicate = NSPredicate(format: "identifier == %@", userAction.identifier)
        let actionTypeFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserActionType")
        actionTypeFetchRequest.predicate = NSPredicate(format: "identifier == %@", userAction.actionType.identifier)
        let userContactFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserContact")
        userContactFetchRequest.predicate = NSPredicate(format: "identifier == %@", userAction.owner.identifier)
        
        do {
            var result = try mainContext.fetch(fetchRequest)
            guard let action = result.first as? NSManagedObject else { return }
            
            result = try mainContext.fetch(actionTypeFetchRequest)
            guard let actionType = result.first as? NSManagedObject else { return }
            
            result = try mainContext.fetch(userContactFetchRequest)
            guard let contact = result.first as? NSManagedObject else { return }
            
            action.setValue(userAction.actionDescription, forKey: "actionDescription")
            action.setValue(userAction.createDate, forKey: "createDate")
            if userAction.finishDate != nil {
                action.setValue(userAction.finishDate, forKey: "finishDate")
            }
            action.setValue(actionType, forKey: "actionType")
            action.setValue(contact, forKey: "owner")
            action.setValue(userAction.identifier, forKey: "identifier")
            
            try mainContext.save()
        } catch {
            print("DatabaseManager error! Failed to update userAction!: \(error.localizedDescription)")
        }
    }
}

// MARK: UserContact functions
extension DatabaseManager {
    
}
