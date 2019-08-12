//
//  TestViewModel.swift
//  InterviewPrepTests
//
//  Created by Alok Upadhyay on 8/12/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import XCTest
@testable import InterviewPrep

class TestSignInViewModel: XCTestCase {

  var viewModel : SignInViewModel?
  
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      viewModel = SignInViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
      viewModel = nil
    }
  
  func testViewModelApiCall(){
    let testExpectation = expectation(description: "We should get successful response with hsbc as username and 123456 as password")
    
    viewModel!.getDataFromService(url: URL(string: (hsbcBaseUrlString + hsbcLoginEndpoint))!, type: SignInResponse.self, httpMethod: "POST", header: ["Content-Type": "application/x-www-form-urlencoded"], param: ["username" : "hsbc" , "password" : "123456"]) {
      testExpectation.fulfill()
    }
    
    wait(for: [testExpectation], timeout: 20)
  }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
