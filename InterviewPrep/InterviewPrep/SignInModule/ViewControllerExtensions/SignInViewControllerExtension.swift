//
//  SignInViewControllerProtocolHndler.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/12/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import Foundation
import UIKit

//code seperation using swift's extension
extension SignInViewController : SignInViewProtocol{
    
  
  func showAlert(message: String) {
    
    showAlert(withMessage: message, andTitle: "Alert!")
  }
  
  func openNewScreen(viewController: UIViewController, token : String) {
    let bookListViewController = BookListViewController(token: token)
    pushViewController(vc: bookListViewController)
  }
}
