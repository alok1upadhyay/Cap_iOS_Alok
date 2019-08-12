//
//  AppErrors.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/9/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import Foundation

/*this associated enum can be used for creating run time error string*/
enum AppErrors : Error{
  case errorInfo(message : String)
}
