

import Foundation
import CoreData


extension WCurrent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WCurrent> {
        return NSFetchRequest<WCurrent>(entityName: "WCurrent")
    }

    @NSManaged public var value: Int32

}

extension WCurrent : Identifiable {

}
