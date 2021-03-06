//
//  Petition.swift
//  project 7
//
//  Created by Kristoffer Eriksson on 2020-09-16.
//  Copyright © 2020 Kristoffer Eriksson. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
