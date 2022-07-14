//
//  NSManagedObjectContext.swift
//  myRecipies
//
//  Created by gaetano cerniglia on 27/10/2019.
//  Copyright © 2019 gaetano cerniglia. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension NSManagedObjectContext {
    /// Property to share the current contex of the NSManagedObjectContext coming from the AppDelegate
    static var current: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType) }
        return appDelegate.persistentContainer.viewContext
    }
}
