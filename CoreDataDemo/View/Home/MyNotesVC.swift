//
//  MyNotesVC.swift
//  RealmDemo
//
//  Created by Sandeep on 13/06/21.
//

import UIKit
import CoreData
protocol MyNotesVeiw : class {
    var tableView: UITableView! { get }
    var addNoteButton: UIBarButtonItem! { get }
    var notes : [NoteData] { get set }
}

class MyNotesVC: UIViewController,MyNotesVeiw {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addNoteButton: UIBarButtonItem!
    var vm : MyNotesVM!
    var uivc : MyNotesUIVC!
    var notes : [NoteData] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = MyNotesVM()
        uivc = MyNotesUIVC()
        vm.view = self
        uivc.view = self
        vm.fetchNotesFromDatabase()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextObjectsDidChange), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: DataController.shared.managedObjectContext)
    }
}

extension MyNotesVC {
    @objc func managedObjectContextObjectsDidChange(notification : NSNotification){
        guard let userInfo = notification.userInfo else { return }
        vm.fetchNotesFromDatabase()

//        if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NoteData>, inserts.count > 0 {
//            print(inserts)
//        }
//
//        if let updates = userInfo[NSUpdatedObjectsKey] as? Set<NoteData>, updates.count > 0 {
//
//        }
//
//        if let deletes = userInfo[NSDeletedObjectsKey] as? Set<NoteData>, deletes.count > 0 {
//            print(deletes)
//        }
    }
}
