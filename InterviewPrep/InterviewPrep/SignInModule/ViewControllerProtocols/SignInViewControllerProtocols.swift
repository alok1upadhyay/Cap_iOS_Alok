//
//  SignInViewControllerProtocols.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/10/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//This class create interface with two required functions
// -showAlert
//-openNewScreen
//what ever view controller implements SignInViewProtocol, have to implement these methods


import Foundation
import UIKit

protocol SignInViewProtocol {
  
  func showAlert(message : String)
  func openNewScreen(viewController : UIViewController, token : String)

}
