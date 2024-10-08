
import Foundation
import CoreData


extension Gold {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Gold> {
        return NSFetchRequest<Gold>(entityName: "Gold")
    }

    @NSManaged public var name: String
    @NSManaged public var profit: Int32
    @NSManaged public var decline: Int32

}

extension Gold : Identifiable {

}
