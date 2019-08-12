//
//  BookListViewController.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/10/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {
  
  var activityIndicatorView : UIActivityIndicatorView?
  var tblView : UITableView?
  var token : String?
  var alertC : UIAlertController?
  
  //BookListViewControllerDelegateHandler will handle all delegate and datasource function
  var bookListViewControllerDelegateHandler :BookListViewControllerDelegateHandler?
  
  init(token : String) {
    super.init(nibName: nil, bundle: nil)
    self.token = token
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Book"
    view.backgroundColor = bgColorSignInView
    // Do any additional setup after loading the view.
    setUpTableView()
    setUpActivityIndicator()
    addFloatingButton()
  }
  
  func setUpActivityIndicator(){
    activityIndicatorView = UIActivityIndicatorView(style: .gray)
    activityIndicatorView?.frame = view.frame
    view.addSubview(activityIndicatorView!)
    activityIndicatorView!.startAnimating()
    activityIndicatorView!.hidesWhenStopped = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  //get data from server and update view
  func getServerData(){
    ApiHandler.callApi(url: URL(string: hsbcBaseUrlString + hsbcBookListEndpoint)!, type: ArrBookListResponse.self, httpMethod: "GET", header: ["Authorization" : self.token!], param: nil) { (response, error) in
      self.activityIndicatorView?.stopAnimating()
      
      if error != nil{
        
        self.showAlert(withMessage: error.debugDescription, andTitle: "Alert!")
        
      }else{
        //safe unwrap to make sure no run time crash
        if let unwrappedResponse = response as? ArrBookListResponse{
          
          self.handleSuccessfullResponse(response: unwrappedResponse)
          
        }else{
          self.handleSuccessfullResponse(response: ArrBookListResponse())
        }
      }
    }
  }
  
  func handleSuccessfullResponse(response : ArrBookListResponse){
    
    if bookListViewControllerDelegateHandler == nil{
      bookListViewControllerDelegateHandler = BookListViewControllerDelegateHandler(dataSourceArray: response)
      tblView?.delegate = bookListViewControllerDelegateHandler
      tblView?.dataSource = bookListViewControllerDelegateHandler
    }else{
      bookListViewControllerDelegateHandler?.updateDataSourceArray(dataSourceArray: response)
    }
    tblView?.reloadData()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
    navigationController?.navigationBar.barTintColor = bgColorSignInView
    navigationItem.setHidesBackButton(true, animated:true);
    getServerData()
    
  }
  
  func addFloatingButton(){
    let btn = UIButton(frame: .zero)
    btn.addTarget(self, action: #selector(addNewBook), for: .touchUpInside)
    btn.setTitle("+", for: .normal)
    btn.contentVerticalAlignment = .center
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 45.0)
    btn.backgroundColor = UIColor.yellow
    btn.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(btn)
    
    btn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    btn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0).isActive = true
    
    //obviuously we can mix approaches
    let widthConstraint = NSLayoutConstraint(item: btn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 50)
    
    let heightConstraint = NSLayoutConstraint(item: btn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 50)
    view.addConstraint(widthConstraint)
    view.addConstraint(heightConstraint)
    view.bringSubviewToFront(btn)
    btn.layer.cornerRadius = 25
  }
  
  
  
  func setUpTableView(){
    
    tblView = UITableView()
    tblView?.estimatedRowHeight = 500
    tblView?.translatesAutoresizingMaskIntoConstraints = false
    tblView?.register(BookCellTableViewCell.self, forCellReuseIdentifier: "cell")
    
    tblView?.delegate = bookListViewControllerDelegateHandler
    tblView?.dataSource = bookListViewControllerDelegateHandler
    
    view.addSubview(tblView!)
    
    let leadingConstraint = NSLayoutConstraint(item: tblView!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
    
    let trailingConstraint = NSLayoutConstraint(item: tblView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
    
    let topConstraint = NSLayoutConstraint(item: tblView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0)
    
    let bottomConstraint = NSLayoutConstraint(item: tblView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
    
    view.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
  }
}


