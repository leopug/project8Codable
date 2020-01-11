//
//  Petition.swift
//  Project8Codable
//
//  Created by Ana Caroline de Souza on 05/01/20.
//  Copyright © 2020 Ana e Leo Corp. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
