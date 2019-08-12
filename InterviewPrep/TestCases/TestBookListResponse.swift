//
//  TestBookListResponse.swift
//  InterviewPrepTests
//
//  Created by Alok Upadhyay on 8/12/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import XCTest
@testable import InterviewPrep

class TestBookListResponse: XCTestCase {

  var bookListResponse : BookListResponse?
  
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      
      bookListResponse = BookListResponse(id: "1", isbn: "isbn123", title: "Google", author: "Google Auth", publisher: "Google Publisher", image: "img", v: 123)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      bookListResponse = nil
    }
  
  //test model class proprties initialization
  func testProperties(){
    XCTAssertTrue(bookListResponse?.author == "Google Auth" && bookListResponse?.id == "1" && bookListResponse?.isbn == "isbn123" && bookListResponse?.title == "Google" && bookListResponse?.author == "Google Auth" && bookListResponse?.publisher == "Google Publisher" && bookListResponse?.v == 123 && bookListResponse?.image == "img")
  }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
