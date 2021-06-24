//
//  DataController.swift
//  CoreDataDemo
//
//  Created by Sandeep on 24/06/21.
//

import Foundation

import UIKit
import CoreData
class DataController: NSObject {
    static let shared = DataController()
    var managedObjectContext: NSManagedObjectContext
    private var persistentContainer : NSPersistentContainer!
    
    private override init() {
        self.persistentContainer = {
            let container = NSPersistentContainer(name: "CoreDataDemo")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            
            return container
        }()
        self.managedObjectContext = persistentContainer.viewContext
    }
    
    func fetchNotesFromDB() -> [NoteData] {
        // Add Sort Descriptor
        let sortDescriptor = NSSortDescriptor(key: "dateModified", ascending: false)
        //NoteData.fetchRequest().sortDescriptors = [sortDescriptor]
        
        let fetchcontext : NSFetchRequest<NoteData>  = NoteData.fetchRequest()
        fetchcontext.sortDescriptors = [sortDescriptor]
        do {
            let fetchedNotes = try managedObjectContext.fetch(fetchcontext)
            return fetchedNotes
        } catch {
            return [NoteData]()
        }
    }
    func save(){
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                print("data not saved")
            }
        }
    }
    var incrementedID : Int {
        get{
            let id = (Int(UserDefaults.standard.string(forKey: "DataController.objectID") ?? "") ?? 0) + 1
            UserDefaults.standard.setValue(id, forKey: "DataController.objectID")
            return id
        }
    }
    
    func delete(id : Int) {
        // Create Fetch Request
        let fetchcontext : NSFetchRequest<NoteData>  = NoteData.fetchRequest()
        // Add Predicate
        let predicate = NSPredicate(format: "id == %@", "\(Int64(id))")
        fetchcontext.predicate = predicate
        do {
            let records = try managedObjectContext.fetch(fetchcontext)
            self.managedObjectContext.delete(records.first!)
            save()
        } catch {
            print(error)
        }
    }
    func update(id : Int, title : String, content : String) {
        // Create Fetch Request
        let fetchcontext : NSFetchRequest<NoteData>  = NoteData.fetchRequest()
        // Add Predicate
        let predicate = NSPredicate(format: "id == %@", "\(Int64(id))")
        fetchcontext.predicate = predicate
        do {
            let records = try managedObjectContext.fetch(fetchcontext)
            let obj = records.first
            obj?.setValue(title, forKey: "title")
            obj?.setValue(content, forKey: "content")
            obj?.setValue(Date(), forKey: "dateModified")
            self.save()
        } catch {
            print(error)
        }
    }
}
