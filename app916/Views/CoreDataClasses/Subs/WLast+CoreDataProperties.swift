
import Foundation
import CoreData


extension WLast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WLast> {
        return NSFetchRequest<WLast>(entityName: "WLast")
    }

    @NSManaged public var value: Int32

}

extension WLast : Identifiable {

}
