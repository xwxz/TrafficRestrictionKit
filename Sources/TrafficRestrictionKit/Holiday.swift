import Foundation

public struct Holiday {
    public let startDate: Date
    public let endDate: Date
    public let holidayName: String
    
    public init(startDate: Date, endDate: Date, holidayName: String) {
        self.startDate = startDate
        self.endDate = endDate
        self.holidayName = holidayName
    }
}
