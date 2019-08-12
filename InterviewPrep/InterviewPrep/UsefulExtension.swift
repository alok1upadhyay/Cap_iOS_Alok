//
//  UsefulExtension.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/11/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import Foundation
import UIKit

/*
 we can keep all the reusable codes in this extension file
 */

extension UIViewController{
  
  /*extension on view controller file so that any view controller class or subclass can call it.
   */
  func showAlert(withMessage message : String, andTitle title : String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default) { (alertAction) in
      alert.dismiss(animated: true, completion: {
        
      })
    }
    alert.addAction(action)
    present(alert, animated: true, completion: {})
  }
}

extension UIViewController{
  
  /*extension for shorhand push
   */
  func pushViewController(vc : UIViewController){
    navigationController?.pushViewController(vc, animated: true)
  }
}

/*extension for padding in UITextfield ex=> in login screen
 */
extension UITextField {
  func setLeftPaddingPoints(_ amount:CGFloat){
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }
  func setRightPaddingPoints(_ amount:CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
    self.rightView = paddingView
    self.rightViewMode = .always
  }
}
