//
//  BookListViewControllerExtension.swift
//  InterviewPrep

//This class acts as a delegate handler of BookListViewController. With this approach we can seperate all delegate and datasource in seperate class adn easily mock test it.

//  Created by Alok Upadhyay on 8/12/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import Foundation
import UIKit

class BookListViewControllerDelegateHandler : NSObject, UITableViewDelegate, UITableViewDataSource{
  
  var dataSourceArray : ArrBookListResponse?
  
  init(dataSourceArray : ArrBookListResponse) {
    self.dataSourceArray = dataSourceArray
  }
  
  func updateDataSourceArray(dataSourceArray : ArrBookListResponse) {
    self.dataSourceArray = dataSourceArray
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("row count >> \(dataSourceArray?.count ?? 0)")
    
    /*safe unwrap using nil coelescing operator ??*/
    return (dataSourceArray?.count) ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? BookCellTableViewCell
    
    /*safe unwrap*/
    if let unwrappedArray = dataSourceArray{
      
      cell?.updateCellData(bookListResponse: unwrappedArray[0])
    }
    
    return cell ?? BookCellTableViewCell()
  }
  
}
