//
//  MyTableViewController.swift
//  iOSFinalAssessmentQ5
//
//  Created by 洪德晟 on 2016/12/4.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var ImageArray = ["gakki", "gakki", "gakki", "gakki", "gakki"]
    var LabelArray = ["gakki", "gakki", "gakki", "gakki", "gakki"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
//            if let okImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//                // 8. 設定畫面上的imageView是我們照的照片
//                myImage.image = okImage
//                // 9. 存檔
//                UIImageWriteToSavedPhotosAlbum(okImage, nil, nil, nil)
//            }
            dismiss(animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImageArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTableViewCell

        // Configure the cell...
        cell.myImage.image = UIImage(named: ImageArray[indexPath.row])
        cell.myLabel.text = LabelArray[indexPath.row]

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
            ImageArray.remove(at: indexPath.row)
            LabelArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
                dvc?.myImage = self.ImageArray[indexPath.row]
                dvc?.myLabel = self.LabelArray[indexPath.row]
            }
        }
    }
    

}
