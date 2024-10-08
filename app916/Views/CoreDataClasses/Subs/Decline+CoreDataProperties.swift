

import Foundation
import CoreData


extension Decline {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Decline> {
        return NSFetchRequest<Decline>(entityName: "Decline")
    }

    @NSManaged public var decline: String

}

extension Decline : Identifiable {

}
