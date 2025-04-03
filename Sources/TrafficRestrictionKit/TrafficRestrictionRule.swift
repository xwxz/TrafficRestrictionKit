// Sources/TrafficRestrictionKit/TrafficRestrictionRule.swift
import Foundation

public struct TrafficRestrictionRule {
    public let startDate: Date
    public let endDate: Date
    public let restrictions: [DayOfWeek: String]
    
    public init(startDate: Date, endDate: Date, restrictions: [DayOfWeek: String]) {
        self.startDate = startDate
        self.endDate = endDate
        self.restrictions = restrictions
    }
}

public enum DayOfWeek: CaseIterable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    public var description: String {
        switch self {
        case .sunday: return "星期日"
        case .monday: return "星期一"
        case .tuesday: return "星期二"
        case .wednesday: return "星期三"
        case .thursday: return "星期四"
        case .friday: return "星期五"
        case .saturday: return "星期六"
        }
    }
    
    // 将整数（1-7，1=星期日）转换为 DayOfWeek
    public init?(rawValue: Int) {
        switch rawValue {
        case 1: self = .sunday
        case 2: self = .monday
        case 3: self = .tuesday
        case 4: self = .wednesday
        case 5: self = .thursday
        case 6: self = .friday
        case 7: self = .saturday
        default: return nil
        }
    }
    
    // 将字符串（如 "Monday"）转换为 DayOfWeek
    public init?(from string: String) {
        switch string.lowercased() {
        case "sunday": self = .sunday
        case "monday": self = .monday
        case "tuesday": self = .tuesday
        case "wednesday": self = .wednesday
        case "thursday": self = .thursday
        case "friday": self = .friday
        case "saturday": self = .saturday
        default: return nil
        }
    }
}
