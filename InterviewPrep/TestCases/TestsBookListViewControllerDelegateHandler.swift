//
//  BookListViewControllerDelegateHandler.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/12/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import XCTest
@testable import InterviewPrep

class TestsBookListViewControllerDelegateHandler: XCTestCase {

  var bookListViewControllerDelegateHandler :BookListViewControllerDelegateHandler?
  var tableView : UITableView?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      
      //init a mock object
      let bookListResp = BookListResponse(id: "1", isbn: "isbn123", title: "Google", author: "Google Auth", publisher: "Google Publisher", image: "img", v: 123)
      
      //initialize delegate handler class
      bookListViewControllerDelegateHandler = BookListViewControllerDelegateHandler(dataSourceArray: [bookListResp])

    }
  //this test case tests for table view set up and delegate and datasource handler initialisation
  func testTableview(){
    tableView = UITableView()
    tableView?.delegate = bookListViewControllerDelegateHandler
    tableView?.dataSource = bookListViewControllerDelegateHandler
    XCTAssertEqual(tableView?.numberOfRows(inSection: 0), bookListViewControllerDelegateHandler?.dataSourceArray?.count)
  }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      bookListViewControllerDelegateHandler = nil

    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
