//
//  BookCellTableViewCell.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/10/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import UIKit

class BookCellTableViewCell: UITableViewCell {
  
  /*access mofdifier for encapsulation*/
   private var imgView : UIImageView?
   private var lblTitle : UILabel?
   private var lblAuthor : UILabel?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUpUI()

  }
  
  private func setUpUI(){
    
    setUpImageView()
    setUpTitle()
    setUpAuthor()
  }
  
  private func getLabel() -> UILabel{
    let l = UILabel(frame: .zero)
    
    l.numberOfLines = 0
    l.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(l)
    return l
  }
  
  private func setUpAuthor(){
    
    lblAuthor = getLabel()
    
    //anchor seems less code
    lblAuthor!.leftAnchor.constraint(equalTo: imgView!.rightAnchor, constant: 16.0).isActive = true
    lblAuthor!.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16.0).isActive = true
    
    lblAuthor!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0).isActive = true
    lblAuthor!.topAnchor.constraint(equalTo: (lblTitle?.bottomAnchor)!, constant: 16.0).isActive = true
  
  }
  
  private func setUpTitle(){
    
    lblTitle = getLabel()
    
    //anchor seems less code
    lblTitle!.leftAnchor.constraint(equalTo: imgView!.rightAnchor, constant: 16.0).isActive = true
    lblTitle!.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16.0).isActive = true

    lblTitle!.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0).isActive = true
    
  }
  
  private func setUpImageView(){
    imgView = UIImageView(frame: .zero)
    imgView?.image = UIImage(named: "imgPlaceholder")
    imgView?.contentMode = .scaleAspectFit
    imgView?.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(imgView!)
    
    //more code but expressive
    let widthConstraint = NSLayoutConstraint(item: imgView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 120)
    
    let heightConstraint = NSLayoutConstraint(item: imgView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 80)
    
    //anchor seems less code
    imgView!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
    imgView!.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
    imgView?.layoutIfNeeded()
    
    contentView.addConstraint(widthConstraint)
    contentView.addConstraint(heightConstraint)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  public func updateCellData(bookListResponse : BookListResponse){
    
    lblTitle?.text = bookListResponse.title
    lblAuthor?.text = bookListResponse.author
    ImageCache.shared.fetchImage(url: URL(string: bookListResponse.image)!, callback: { (image) in
      self.imgView?.image = image
    })
  }
}
