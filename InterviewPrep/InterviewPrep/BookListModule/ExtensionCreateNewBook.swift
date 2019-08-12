//
//  ExtensionCreateNewBook.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/12/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import Foundation
import UIKit

extension BookListViewController{
  
  @objc func addNewBook(){
    
    alertC = UIAlertController(title: "Add New Book", message: "Fill Below Details", preferredStyle: .alert)
    
    var _textFieldIsbn :UITextField?
    var _textFieldId :UITextField?
    var _textFieldPublisher : UITextField?
    var _textFieldAuthor : UITextField?
    var _textFieldTitle : UITextField?
    var _textFieldV : UITextField?
    var _textFieldImagePath : UITextField?
    
    alertC?.addTextField { (textFieldId) in
      textFieldId.placeholder = "Enter Book Id"
      textFieldId.becomeFirstResponder()
      _textFieldId = textFieldId
    }
    
    alertC?.addTextField { (textFieldPublisher) in
      textFieldPublisher.placeholder = "Enter Book publisher"
      _textFieldPublisher = textFieldPublisher
    }
    
    alertC?.addTextField { (textFieldAuthor) in
      textFieldAuthor.placeholder = "Enter Book Author"
      _textFieldAuthor = textFieldAuthor
    }
    
    alertC?.addTextField { (textFieldTitle) in
      textFieldTitle.placeholder = "Enter Book Title"
      _textFieldTitle = textFieldTitle
    }
    
    alertC?.addTextField { (textFieldIsbn) in
      textFieldIsbn.placeholder = "Enter Book ISBN"
      _textFieldIsbn = textFieldIsbn
    }
    
    alertC?.addTextField { (textFieldV) in
      textFieldV.placeholder = "Enter Book version"
      _textFieldV = textFieldV
    }
    
    alertC?.addTextField { (textFieldImagePath) in
      textFieldImagePath.text = "https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/evolving_google_identity_share.jpg"
      _textFieldImagePath = textFieldImagePath
    }
    
    alertC?.addAction(setUpSubmitAction(__id: _textFieldId?.text, isbn: _textFieldIsbn?.text, title: _textFieldTitle?.text, author: _textFieldAuthor?.text, publisher: _textFieldPublisher?.text, image: _textFieldImagePath?.text, __v: _textFieldV?.text))
    
    alertC?.addAction(setUpCancel())
    
    present(alertC!, animated: true, completion: nil)
    
  }
  
  func setUpCancel() -> UIAlertAction{
    let action = UIAlertAction(title: "CANCEL", style: .cancel) { (_) in
      self.alertC?.dismiss(animated: true, completion: nil)
    }
    
    return action
  }
  
  func setUpSubmitAction(__id : String?, isbn : String?, title : String?, author : String?, publisher : String?, image : String?, __v : String?) -> UIAlertAction{
    
    let submitAction = UIAlertAction(title: "SUBMIT", style: .default) { [weak self] (_) in
      
      let postDictionary = ["isbn" : isbn ?? "defaultISBN", "title" :title ?? "defaultTitle", "author" : author ?? "defaultAuthor", "publisher" : publisher ?? "defaultPublisher", "image" : image, "__v" : __v ?? "defaultVer1.000", "__id" : __id ?? "defaultId321"]
      
      let postHeader = ["Authorization" : self?.token, "Content-Type": "application/x-www-form-urlencoded"]
      
      let act = UIActivityIndicatorView(style: .gray)
      act.frame = self!.view.frame
      self?.view.addSubview(act)
      act.startAnimating()
      act.hidesWhenStopped = true
      
      ApiHandler.callApi(url: URL(string: (hsbcBaseUrlString + hsbcBookListEndpoint))!, type: CreateBookResponse.self, httpMethod: "POST", header: postHeader as! [String : String], param: (postDictionary as! Dictionary<String, String>), CompletionHandler: { [weak self] (model, error) in
        
        act.stopAnimating()
        self?.handleResponse(model: model, error: error)
      }
      )
    }
    return submitAction
  }
  
  func handleResponse(model : Any?, error : Error?){
    self.alertC?.dismiss(animated: true, completion:nil)
    
    if error != nil{
      self.showAlert(withMessage: error.debugDescription, andTitle: "Alert!")
    }else{
      let respModel  = model as! CreateBookResponse
      self.showAlert(withMessage: respModel.msg, andTitle: "Alert!")
    }
  }
}
