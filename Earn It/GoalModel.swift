//
//  GoalModel.swift
//  Earn It
//
//  Created by McCay on 12/29/14.
//  Copyright (c) 2014 Change5. All rights reserved.
//

import Foundation
import CoreData


@objc(GoalModel)
class GoalModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var goaldescription: String
    @NSManaged var goal: String

}
