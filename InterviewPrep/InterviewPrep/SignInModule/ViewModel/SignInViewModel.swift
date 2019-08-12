//
//  SignInViewModel.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/9/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import Foundation

class SignInViewModel {
  
  private var signInResponseInfo : SignInResponseInfo?
  
  func getDataFromService<T: Decodable>(url: URL,type: T.Type, httpMethod : String, header : [String: String], param : Dictionary<String, String>?, completionBlock: @escaping ()->()){
    
    ApiHandler.callApi(url: url, type: type, httpMethod: httpMethod, header: header, param: param) { [weak self] (model, error) in
      
      self?.signInResponseInfo = SignInResponseInfo(signInResponse: (model as? SignInResponse) ?? SignInResponse(), error: error)
      completionBlock()
    }
  }
  
  func getSuccessInfo() -> Bool?{
    
    return signInResponseInfo?.signInResponse?.success
  }
  
  func getToken() -> String?{
    return signInResponseInfo?.signInResponse?.token
  }
  
  func getError()->Error?{
    return signInResponseInfo?.error
    
  }
  
}

struct SignInResponseInfo {
  
  var signInResponse : SignInResponse?
  var error : Error?
  
}
