//
//  MyTableViewController.swift
//  iOSFinalAssessmentQ5
//
//  Created by 洪德晟 on 2016/12/4.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit
import RealmSwift

class MyObject: Object {
    
    dynamic var myPhoto = ""
    dynamic var myDescri = ""
    dynamic var date = NSDate()
    
}

class MyTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let realm = try! Realm()
    let results = try! Realm().objects(MyObject.self).sorted(byProperty: "date")
    var notificationToken: NotificationToken?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        print("*****\(results)*****")
        
        // Set results notification block
        self.notificationToken = results.addNotificationBlock { (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                self.tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the TableView
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.reloadRows(at: modifications.map { IndexPath(row: $0, section: 0) }, with: .automatic)
                self.tableView.endUpdates()
                break
            case .error(let err):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(err)")
                break
            }
        }
        
    }
        
    func setUpUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,target: self, action: #selector(addPhoto))
    }
    
    func addPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("==No camera exist!==")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let okImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let interval = Date.timeIntervalSinceReferenceDate
            let name = "\(interval).jpg"
            let url = docUrl.appendingPathComponent(name)
            let data = UIImageJPEGRepresentation(okImage, 0.9)
            try! data?.write(to: url)
            
            realm.beginWrite()
            realm.create(MyObject.self, value: ["myPhoto" : name,"myDescri": "請輸入圖片註解", "date": Date()])
            try! realm.commitWrite()
        }
        print("*****\(results)*****")
        
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTableViewCell
        
        // Configure the cell...
        let object = results[indexPath.row]
        let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = docUrl.appendingPathComponent(object.myPhoto)
        let data = NSData(contentsOf: url)
        
        if FileManager.default.fileExists(atPath: url.path) {
            let image = UIImage(data: data! as Data)
            cell.myImage.image = image
            cell.myLabel.text = object.myDescri
        } else {
            cell.myImage.image = UIImage(named: "gakki")
            cell.myLabel.text = "沒有你所拍攝的圖片唷！"
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            realm.beginWrite()
            realm.delete(results[indexPath.row])
            try! realm.commitWrite()
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as? DetailViewController
                dvc?.myObject = results[indexPath.row]
            }
        }
    }
    

}
