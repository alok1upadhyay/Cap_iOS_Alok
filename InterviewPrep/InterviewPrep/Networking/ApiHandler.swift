//
//  ApiHandler.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/7/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

/*this class can be used for API calling*/


import Foundation

/*this completion handler can return any type of model object and error*/

typealias CompletionHandler = (Any?, Error?) -> ()

class ApiHandler: NSObject {
  
  /*this function created & string to be sent in post data. class functions need not instances, so they are easy to call on*/
  private class func getSerializeData(param: Dictionary<String, String>?) -> Data?{
    
    var postData : Data?
    if let unwrappedParam = param
    {
        var str = ""
      
        for (key, value) in unwrappedParam{
          str = str + key + "=" + value + "&"
        }
      
        let s = str.dropLast()
        print(s)
        postData = NSMutableData(data: s.data(using: String.Encoding.utf8)!) as Data

        return postData
    }else{
      print("postData is nil")
      return postData
    }
  }
  
  /*this function created url with http properties*/
  private class func getUrlRequest(url : URL,httpMethod : String = "GET", postData : Data?, header : [String: String]) -> URLRequest?{
    
    var request : URLRequest?
      request = URLRequest(url: url)
    
      request?.httpMethod = httpMethod
      request?.allHTTPHeaderFields = header
    
      request?.httpBody = postData
    
    return request
  }
  
  /*this function can be used for calling api with get or post or parameters or http headers.
   good use case of generics, so just tell it the type you need it will decode and give you that type object
   */

  class func callApi<T: Decodable>(url : URL, type: T.Type, httpMethod : String = "GET", header : [String: String], param: Dictionary<String, String>?, CompletionHandler: @escaping CompletionHandler){

    let postData = getSerializeData(param: param)
    let request  = getUrlRequest(url: url, httpMethod : httpMethod, postData: postData, header: header)
    
    if let requestUnwrapped = request{
      
      processRequest(type: type , request: requestUnwrapped) { (model, error) in
        DispatchQueue.main.async {
          
          CompletionHandler(model, error)

        }
      }

    }else{
      
      print("!!!!request is nil !!!!")
      DispatchQueue.main.async {
        CompletionHandler(nil, AppErrors.errorInfo(message: "Request is nil"))

      }
    }
    }
  
  /*simple apple's inbult url session class used to network call
   */
  private class func processRequest<T: Decodable>(type: T.Type, request : URLRequest, CompletionHandler: @escaping CompletionHandler){
    
    URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
      if(data != nil){
        do{
          let model = try JSONDecoder().decode(type.self, from: data!)
          CompletionHandler(model, nil)
          
        }catch{
          print(error)
          CompletionHandler(nil, error)
        }
      }else{
        CompletionHandler(nil, error)
      }
    }).resume()
  }
}
