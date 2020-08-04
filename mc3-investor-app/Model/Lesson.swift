//
//  Lesson.swift
//  mc3-investor-app
//
//  Created by Adrian Renaldi on 04/08/20.
//  Copyright © 2020 Jeffry Steward W. All rights reserved.
//

import Foundation

struct Lesson: Codable {
    let id: Int?
    let code: String?
    let name: String?
    let image: String?
    let desc1: [String?]
    let desc2: [String?]
    let descImage: [String?]
    var isLock: Bool?
}
