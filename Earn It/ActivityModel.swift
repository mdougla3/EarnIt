//
//  ActivityModel.swift
//  Earn It
//
//  Created by McCay on 12/26/14.
//  Copyright (c) 2014 Change5. All rights reserved.
//

import Foundation
import CoreData


@objc(ActivityModel)
class ActivityModel: NSManagedObject {
    
    @NSManaged var completed:NSNumber
    @NSManaged var activity:String
    @NSManaged var activitydescription:String
    @NSManaged var date:NSDate

}