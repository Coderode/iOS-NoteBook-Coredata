//
//  NoteData+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Sandeep on 24/06/21.
//
//

import Foundation
import CoreData


extension NoteData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteData> {
        return NSFetchRequest<NoteData>(entityName: "Note")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var dateModified: Date?

}

extension NoteData : Identifiable {

}
