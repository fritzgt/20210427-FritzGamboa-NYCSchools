//
//  Schools+Convinience.swift
//  20210427-FritzGamboa-NYCSchools
//
//  Created by FGT MAC on 4/28/21.
//

import Foundation
import CoreData

extension Schools {
    convenience init(dbn:String, neighborhood: String, schoolName: String,totalStudents:String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context:context)
        
        self.dbn = dbn
        self.neighborhood = neighborhood
        self.schoolName = schoolName
        self.totalStudents = totalStudents
    }
}
