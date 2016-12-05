//
//  DetailViewController.swift
//  iOSFinalAssessmentQ5
//
//  Created by 洪德晟 on 2016/12/4.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController, UIScrollViewDelegate  {
    
    var myObject:MyObject?
    
    @IBOutlet weak var MyScrollView: UIScrollView!
    @IBOutlet weak var MyDetailImage: UIImageView!
    @IBOutlet weak var MyDetailTextField: UITextField!
    @IBAction func updateText(_ sender: Any) {
        if let newText = MyDetailTextField.text {
            let root = self.navigationController?.viewControllers.first as! MyTableViewController
            let realm = root.realm
            print("==========input==========")
            try! realm.write {
                myObject?.myDescri = newText
                print("*****\(myObject)*****")
            }
        }        
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return MyDetailImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyScrollView.contentSize = CGSize(width: self.MyScrollView.frame.width, height: self.MyScrollView.frame.height)
//        MyDetailImage.frame = CGRect(x: Int(self.view.frame.width/2), y: Int(self.view.frame.height/2), width: 300, height: 300)
        
        let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = docUrl.appendingPathComponent((myObject?.myPhoto)!)
        let data = NSData(contentsOf: url)
        let image = UIImage(data: data! as Data)
        let textOfImage = myObject?.myDescri

            MyDetailImage.image = image
            MyDetailTextField.text = textOfImage
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,target: self, action: #selector(share))
        
    }
    
    func share() {
        let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = docUrl.appendingPathComponent((myObject?.myPhoto)!)
        let data = NSData(contentsOf: url)
        let image = UIImage(data: data! as Data)
        let textOfImage = myObject?.myDescri

        let activity = UIActivityViewController(activityItems: [image, textOfImage], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// 收鍵盤
extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
