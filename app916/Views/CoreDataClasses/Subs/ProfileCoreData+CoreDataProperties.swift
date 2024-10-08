
import Foundation
import CoreData


extension ProfileCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileCoreData> {
        return NSFetchRequest<ProfileCoreData>(entityName: "ProfileCoreData")
    }

    @NSManaged public var image: Data?
    @NSManaged public var name: String

}

extension ProfileCoreData : Identifiable {

}
