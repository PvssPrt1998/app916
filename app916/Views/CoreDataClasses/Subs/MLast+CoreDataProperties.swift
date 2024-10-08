
import Foundation
import CoreData


extension MLast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MLast> {
        return NSFetchRequest<MLast>(entityName: "MLast")
    }

    @NSManaged public var value: Int32

}

extension MLast : Identifiable {

}
