import Foundation
import CoreData


extension TotalBalance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TotalBalance> {
        return NSFetchRequest<TotalBalance>(entityName: "TotalBalance")
    }

    @NSManaged public var balance: String

}

extension TotalBalance : Identifiable {

}
