import Foundation
import CoreData


extension DCurrent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DCurrent> {
        return NSFetchRequest<DCurrent>(entityName: "DCurrent")
    }

    @NSManaged public var value: Int32

}

extension DCurrent : Identifiable {

}
