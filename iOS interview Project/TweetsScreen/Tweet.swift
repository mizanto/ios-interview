//
//  Tweet.swift
//  iOS interview Project
//
//  Created by Sergei Bendak on 11.05.2020.
//  Copyright © 2020 ExperimentX. All rights reserved.
//

import Foundation

struct Tweet: Codable {
    let name: String
    let avatar: String
    let text: String
    let date: String
    let image: String?
}
