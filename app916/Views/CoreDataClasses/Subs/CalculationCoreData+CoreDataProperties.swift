
import Foundation
import CoreData


extension CalculationCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CalculationCoreData> {
        return NSFetchRequest<CalculationCoreData>(entityName: "CalculationCoreData")
    }

    @NSManaged public var title: String
    @NSManaged public var marketValue: Int32
    @NSManaged public var profit: Int32
    @NSManaged public var commission: Double
    @NSManaged public var tax: Double
    @NSManaged public var netProfit: Double

}

extension CalculationCoreData : Identifiable {

}
