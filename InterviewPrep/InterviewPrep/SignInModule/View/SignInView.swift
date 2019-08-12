//
//  SignInView.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/9/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import UIKit

class SignInView: UIView {

  public var viewModel : SignInViewModel?
  public var delegate_SignInViewProtocol : SignInViewProtocol?
  
  private var txtUsername : UITextField?
  private var txtPassword : UITextField?
  private var btnLogin : UIButton?
  private var activityIndicator : UIActivityIndicatorView?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  private func getImage(named : String) -> UIImageView{
    
    let imgView = UIImageView(frame: .zero)
    imgView.contentMode = .scaleAspectFit
    imgView.backgroundColor = bgColorSignInView
    imgView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(imgView)
    imgView.image = UIImage(named: named)
    return imgView
  }
  
  private func getBgImageView() -> UIImageView{
    
    let imgView = getImage(named: "imgBackground")
    
    //autolayout setup

    let widthConstraint = NSLayoutConstraint(item: imgView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0)
    
    let heightConstraint = NSLayoutConstraint(item: imgView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0)
    
    let horizontalCentarConstraint = NSLayoutConstraint(item: imgView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
    
    let verticalCentarConstraint = NSLayoutConstraint(item: imgView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
    
    addConstraint(widthConstraint)
    addConstraint(heightConstraint)
    addConstraint(horizontalCentarConstraint)
    addConstraint(verticalCentarConstraint)
    return imgView
  }
  
  private func getTopImageView() -> UIImageView{
  
    let imgView = getImage(named: "bulb")
    imgView.layer.cornerRadius = 60.0
    imgView.layer.shadowColor = bgColorSignInView.withAlphaComponent(0.2).cgColor
    
    let widthConstraint = NSLayoutConstraint(item: imgView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 120)
    
    let heightConstraint = NSLayoutConstraint(item: imgView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 120)
    
    let horizontalCentarConstraint = NSLayoutConstraint(item: imgView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
    
    let yConstraint = NSLayoutConstraint(item: imgView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 50.0)
    
    addConstraint(widthConstraint)
    addConstraint(heightConstraint)
    addConstraint(horizontalCentarConstraint)
    addConstraint(yConstraint)
    return imgView
  }
  
  private func getTextField(placeHolder : String) -> UITextField{
    
    let aTxtField = UITextField()
    aTxtField.delegate = self
    aTxtField.setLeftPaddingPoints(5.0)
    aTxtField.setRightPaddingPoints(5.0)
    setUpDefaultTransition(txtField: aTxtField)
    aTxtField.textColor = fontColorUserNameTextField
    aTxtField.autocapitalizationType = .none
    aTxtField.autocorrectionType = .no
    aTxtField.backgroundColor = UIColor.white
    aTxtField.translatesAutoresizingMaskIntoConstraints = false
    aTxtField.placeholder = placeHolder
    addSubview(aTxtField)
    return aTxtField
  }
  
  private func getUserNameTextField(neighbourView : UIView) -> UITextField{
  
    let txtUsername = getTextField(placeHolder: "Username")
    
    let txtUsername_leading = NSLayoutConstraint(item: txtUsername, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 32.0)
    let txtUsername_trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: txtUsername, attribute: .trailing, multiplier: 1.0, constant: 32.0)
    
    let txtUsername_top = NSLayoutConstraint(item: txtUsername, attribute: .top, relatedBy: .equal, toItem: neighbourView, attribute: .bottom, multiplier: 1.0, constant: 64.0)
    let txtUsername_height = NSLayoutConstraint(item: txtUsername, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 64.0)
    
    addConstraints([txtUsername_leading, txtUsername_trailing, txtUsername_top, txtUsername_height])
    txtUsername.becomeFirstResponder()
    return txtUsername
  }
  
  private func getPasswordTextField(neighbourView : UIView) -> UITextField{
    
    let txtPassword = getTextField(placeHolder: "Password")
    txtPassword.isSecureTextEntry = true

    let txtPassword_leading = NSLayoutConstraint(item: txtPassword, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 32.0)
    let txtPassword_trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: txtPassword, attribute: .trailing, multiplier: 1.0, constant: 32.0)
    let txtPassword_top = NSLayoutConstraint(item: txtPassword, attribute: .top, relatedBy: .equal, toItem: neighbourView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
    let txtPassword_height = NSLayoutConstraint(item: txtPassword, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 64.0)
    
    addConstraints([txtPassword_leading, txtPassword_trailing, txtPassword_top, txtPassword_height])

    return txtPassword
  }
  
  private func getButton() -> UIButton{
    let btn = UIButton()
    btn.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    btn.backgroundColor = UIColor.white
    btn.setTitleColor(fontColorLoginButton, for: .normal)
    btn.titleLabel?.textColor = fontColorLoginButton
    btn.translatesAutoresizingMaskIntoConstraints = false
    btn.setTitle("Login", for: .normal)
    addSubview(btn)
    return btn
  }
  
  private func getLoginButton(neighbourView : UIView) -> UIButton{
    
    let btn = getButton()
    
    //autolayout setup

    let btn_leading = NSLayoutConstraint(item: btn, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 32.0)
    let btn_trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: btn, attribute: .trailing, multiplier: 1.0, constant: 32.0)
    let btn_top = NSLayoutConstraint(item: btn, attribute: .top, relatedBy: .equal, toItem: neighbourView, attribute: .bottom, multiplier: 1.0, constant: 32.0)
    let btn_height = NSLayoutConstraint(item: btn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 64.0)
    
    addConstraints([btn_leading, btn_trailing, btn_top, btn_height])
    
    return btn
    
  }
  
  private func commonInit(){
    
    txtUsername = getUserNameTextField(neighbourView: getTopImageView())
    txtPassword = getPasswordTextField(neighbourView: txtUsername!)
    btnLogin = getLoginButton(neighbourView: txtPassword!)
    
  }
  
  private func setUpActivity(){
   
    activityIndicator = UIActivityIndicatorView(style: .gray)
    activityIndicator?.frame = (btnLogin?.frame)!
    activityIndicator!.frame.origin.y = activityIndicator!.frame.origin.y - 20
    activityIndicator!.startAnimating()
    addSubview(activityIndicator!)

  }
  
  private func startLoginTransition(){
    
    setUpActivity()
    btnLogin?.setTitle("Login In Progress...", for: .normal)
    btnLogin?.backgroundColor = UIColor.init(white: 0.8, alpha: 0.8)
    isUserInteractionEnabled = false
  }
  
  private func stopLoginTransition(){
    
    btnLogin?.setTitle("LOG IN", for: .normal)
    btnLogin?.backgroundColor = UIColor.white
    isUserInteractionEnabled = true
    activityIndicator!.stopAnimating()
    activityIndicator!.removeFromSuperview()

  }
  
  private func setUpErrorTransition(txtField : UITextField){
    
    txtField.layer.borderColor = UIColor.red.cgColor
    txtField.layer.borderWidth = 2
  }
  
  func setUpDefaultTransition(txtField : UITextField){
    
    txtField.layer.borderColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1).cgColor
    txtField.layer.borderWidth = 0.5
  }
  
  func isValid() -> Bool{
    
    if txtUsername?.text?.count == 0 && txtPassword?.text?.count == 0{
      setUpErrorTransition(txtField: txtUsername!)
      setUpErrorTransition(txtField: txtPassword!)

      delegate_SignInViewProtocol?.showAlert(message: "Please Enter Both Username & Password")

      return false
    }
    
    if txtUsername?.text?.count == 0{
      setUpErrorTransition(txtField: txtUsername!)
      delegate_SignInViewProtocol?.showAlert(message: "Please Enter Username")
      return false
    }
    if txtPassword?.text?.count == 0{
      setUpErrorTransition(txtField: txtPassword!)
      delegate_SignInViewProtocol?.showAlert(message: "Please Enter Password")
      return false
    }
    
    return true
    
  }
  
 @objc private func signInButtonClicked(){

  if isValid(){
  
  startLoginTransition()

  viewModel?.getDataFromService( url: URL(string : hsbcBaseUrlString + hsbcLoginEndpoint)!, type: SignInResponse.self, httpMethod: "POST", header: ["Content-Type": "application/x-www-form-urlencoded"], param: ["username" : (txtUsername?.text)! , "password" : (txtPassword?.text)!], completionBlock: {
    [weak self] in
    
    self!.stopLoginTransition()
    
    guard let delegate = self!.delegate_SignInViewProtocol else{
      print("check your delegate is nil")
      return
    }
    
    let anyError = self!.viewModel?.getError()
    if anyError != nil {
        delegate.showAlert(message: anyError.debugDescription)
      return
    }
    
    if self!.viewModel?.getSuccessInfo() == true{
    
    //progress next
      delegate.openNewScreen(viewController: UIViewController(), token: (self!.viewModel?.getToken())!)
    }else{
      delegate.showAlert(message: "Please Check Username & Password.")
    }

  })
  }
  
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
