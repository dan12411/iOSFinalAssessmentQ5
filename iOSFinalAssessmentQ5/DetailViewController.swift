//
//  DetailViewController.swift
//  iOSFinalAssessmentQ5
//
//  Created by 洪德晟 on 2016/12/4.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate  {
    
    var myImage:String?
    var myLabel: String?
    
    @IBOutlet weak var MyScrollView: UIScrollView!
    @IBOutlet weak var MyDetailImage: UIImageView!
    @IBOutlet weak var MyDetailTextField: UITextField!

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return MyDetailImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyScrollView.contentSize = CGSize(width: self.MyScrollView.frame.width, height: self.MyScrollView.frame.height)
//        MyDetailImage.frame = CGRect(x: Int(self.view.frame.width/2), y: Int(self.view.frame.height/2), width: 300, height: 300)
        
        if let myImage = myImage, let myLabel = myLabel {
            MyDetailImage.image = UIImage(named: myImage)
            MyDetailTextField.text = myLabel
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,target: self, action: #selector(share))
        
    }
    
    func share() {
        if let myImage = myImage, let myLabel = myLabel {
            if let shareImage = UIImage(named: myImage) {
                let activity = UIActivityViewController(activityItems: [shareImage, myLabel], applicationActivities: nil)
                present(activity, animated: true, completion: nil)
            }
        }
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
