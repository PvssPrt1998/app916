
import Foundation
import CoreData


extension DLast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DLast> {
        return NSFetchRequest<DLast>(entityName: "DLast")
    }

    @NSManaged public var value: Int32

}

extension DLast : Identifiable {

}
