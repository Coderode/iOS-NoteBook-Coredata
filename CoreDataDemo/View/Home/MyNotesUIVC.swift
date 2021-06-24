//
//  MyNotesUIVC.swift
//  RealmDemo
//
//  Created by Sandeep on 13/06/21.
//

import UIKit

class MyNotesUIVC: NSObject {
    weak var view : MyNotesVeiw! {
        didSet{
            setupUI()
        }
    }
    func setupUI(){
        self.view.addNoteButton.target = self
        self.view.addNoteButton.action = #selector(didTaponAddNoteButton)
        self.view.tableView.separatorStyle = .none
        self.view.tableView.dataSource = self
        self.view.tableView.delegate = self
    }
    
    @objc func didTaponAddNoteButton(){
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "EditVC") as! EditVC
        vc.editVM = EditVM()
        vc.editUIVC = EditUIVC()
        (self.view as? UIViewController)?.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyNotesUIVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.view.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTVC") as? NotesTVC else {
            return UITableViewCell()
        }
        cell.setData(note: self.view.notes[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "EditVC") as! EditVC
        vc.editVM = EditVM()
        vc.editUIVC = EditUIVC()
        vc.data = self.view.notes[indexPath.row]
        (self.view as? UIViewController)?.navigationController?.pushViewController(vc, animated: true)
    }
}
