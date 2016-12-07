//
//  DetailViewController.swift
//  iOSFinalAssessmentQ5
//
//  Created by 洪德晟 on 2016/12/4.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    var myObject:MyObject?
    
    @IBOutlet weak var MyScrollView: UIScrollView!
    @IBOutlet weak var MyDetailImage: UIImageView!
    @IBOutlet weak var MyDetailTextField: UITextField!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    @IBAction func upateText(_ sender: Any) {
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
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        MyScrollView.contentSize = CGSize(width: self.MyScrollView.frame.width, height: self.MyScrollView.frame.height)
        
        let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = docUrl.appendingPathComponent((myObject?.myPhoto)!)
        let data = NSData(contentsOf: url)
        let image = UIImage(data: data! as Data)
        let textOfImage = myObject?.myDescri

            MyDetailImage.image = image
            MyDetailTextField.text = textOfImage
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,target: self, action: #selector(share))
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // For textField up, when keyboard show up
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 80.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 80.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
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
