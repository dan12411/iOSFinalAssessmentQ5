//
//  DetailViewController.swift
//  iOSFinalAssessmentQ5
//
//  Created by 洪德晟 on 2016/12/4.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var myImage:String?
    var myLabel: String?
    
    @IBOutlet weak var MyDetailImage: UIImageView!
    @IBOutlet weak var MyDetailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let myImage = myImage {
            MyDetailImage.image = UIImage(named: myImage)
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
