
import Foundation
import CoreData


extension MCurrent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MCurrent> {
        return NSFetchRequest<MCurrent>(entityName: "MCurrent")
    }

    @NSManaged public var value: Int32

}

extension MCurrent : Identifiable {

}
