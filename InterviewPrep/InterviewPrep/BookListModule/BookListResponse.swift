//
//  BookListResponse.swift
//  InterviewPrep
//
//  Created by Alok Upadhyay on 8/10/19.
//  Copyright © 2019 Alok Upadhyay. All rights reserved.
//

import UIKit

import Foundation

// MARK: - WelcomeElement
struct BookListResponse: Codable {
  let id, isbn, title, author: String
  let publisher: String
  let image: String
  let v: Int
  
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case isbn, title, author, publisher, image
    case v = "__v"
  }
}

typealias ArrBookListResponse = [BookListResponse]
