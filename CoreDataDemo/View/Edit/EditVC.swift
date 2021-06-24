//
//  EditVC.swift
//  RealmDemo
//
//  Created by Sandeep on 13/06/21.
//

import UIKit

protocol EditView : class {
    var noteDeleteButton: UIButton! { get }
    var noteSaveButton: UIButton! { get }
    var textView: UITextView! { get }
    var titleTextField: UITextField! { get }
    var data : NoteData? { get set }
}

class EditVC: UIViewController, EditView {

    @IBOutlet weak var noteDeleteButton: UIButton!
    @IBOutlet weak var noteSaveButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    var editUIVC : EditUIVC!
    var editVM : EditVM!
    var data : NoteData?
    override func viewDidLoad() {
        super.viewDidLoad()
        editUIVC.view = self
        editVM.view = self
        self.title = "Edit"
    }

}
