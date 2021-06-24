//
//  MyNotesVM.swift
//  RealmDemo
//
//  Created by Sandeep on 13/06/21.
//

import UIKit
class MyNotesVM: NSObject {
    weak  var view : MyNotesVeiw! {
        didSet{
            
        }
    }
    func fetchNotesFromDatabase(){
        let objects = DataController.shared.fetchNotesFromDB()
        self.view.notes = objects
        self.view.tableView.reloadData()
    }
    func updateTableView(deletions: [Int], insertions : [Int], updates: [Int]){
        self.view.tableView.beginUpdates()
        self.view.tableView.deleteRows(at: deletions.map(IndexPath.fromRow), with: .automatic)
        self.view.tableView.insertRows(at: insertions.map(IndexPath.fromRow), with: .automatic)
        self.view.tableView.reloadRows(at: updates.map(IndexPath.fromRow), with: .none)
        self.view.tableView.endUpdates()
    }
}

extension IndexPath {
    static func fromRow(_ row : Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}
