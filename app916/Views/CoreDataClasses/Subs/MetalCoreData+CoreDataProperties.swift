

import Foundation
import CoreData


extension MetalCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MetalCoreData> {
        return NSFetchRequest<MetalCoreData>(entityName: "MetalCoreData")
    }

    @NSManaged public var title: String
    @NSManaged public var profit: Int32
    @NSManaged public var decline: Int32

}

extension MetalCoreData : Identifiable {

}
