
import Foundation
import CoreData


extension Profit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profit> {
        return NSFetchRequest<Profit>(entityName: "Profit")
    }

    @NSManaged public var profit: String

}

extension Profit : Identifiable {

}
