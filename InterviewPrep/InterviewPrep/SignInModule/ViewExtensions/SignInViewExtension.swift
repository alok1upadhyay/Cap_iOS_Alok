//
//  SignInViewExtension.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/12/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import Foundation
import UIKit

//seperated UITextFieldDlegte function in seperate extension, in future this code may grow with other delegates
extension SignInView : UITextFieldDelegate{
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    setUpDefaultTransition(txtField: textField)
  }
}
