//
//  SchoolModelCodable.swift
//  20210427-FritzGamboa-NYCSchools
//
//  Created by FGT MAC on 4/29/21.
//

import Foundation

struct SchoolModelCodable: Codable {
    var dbn : String
    var neighborhood: String
    var schoolName: String
    var totalStudents: String
    var satScores: ScoreModelCodable?
}

