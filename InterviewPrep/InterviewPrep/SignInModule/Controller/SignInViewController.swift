//
//  ViewController.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/7/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
  
  //view controller must have view model
  var viewModel  = SignInViewModel()
  
  //create signUP view object and create User Interface
  private func setUpSignInView(){
    
    let v = SignInView(frame: .zero)
    v.delegate_SignInViewProtocol = self
    v.viewModel = viewModel
    v.backgroundColor = bgColorSignInView
    v.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(v)
    
    //autolayout setup
    let leadingConstraint = NSLayoutConstraint(item: v, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
    
    let trailingConstraint = NSLayoutConstraint(item: v, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
    
    let topConstraint = NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0)
    
    let bottomConstraint = NSLayoutConstraint(item: v, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
    
    view.addConstraint(leadingConstraint)
    view.addConstraint(trailingConstraint)
    view.addConstraint(topConstraint)
    view.addConstraint(bottomConstraint)
  }
    

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
  
  private func setUpUI(){
    edgesForExtendedLayout = []
    setUpSignInView()

  }
}
