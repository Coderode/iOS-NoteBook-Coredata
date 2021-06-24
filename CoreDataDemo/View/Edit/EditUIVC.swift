//
//  EditUIVC.swift
//  RealmDemo
//
//  Created by Sandeep on 13/06/21.
//

import UIKit

class EditUIVC: NSObject {
    weak var view : EditView! {
        didSet{
            setupUI()
        }
    }
    func setupUI(){
        self.view.titleTextField.text = ""
        self.view.textView.text = ""
        self.view.textView.isScrollEnabled = true
        
        if let data = self.view.data {
            self.view.titleTextField.text = data.title
            self.view.textView.text = data.content
        }
    }
}

