// Sources/TrafficRestrictionKit/TrafficRestrictionManager.swift
import Foundation

public class TrafficRestrictionManager {
    // 使用数组存储所有限行规则
    private let rules: [TrafficRestrictionRule]
    
    // 初始化方法，可以传入自定义的规则
    public init(rules: [TrafficRestrictionRule] = TrafficRestrictionManager.defaultRules) {
        self.rules = rules
    }
    
    // 默认的限行规则
    public static let defaultRules: [TrafficRestrictionRule] = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        
        // 辅助函数：将日期字符串转换为 Date
        func date(from string: String) -> Date? {
            return dateFormatter.date(from: string)
        }
        
        let rule1 = TrafficRestrictionRule(
            startDate: date(from: "2025年3月31日")!,
            endDate: date(from: "2025年6月29日")!,
            restrictions: [
                .monday: "1和6",
                .tuesday: "2和7",
                .wednesday: "3和8",
                .thursday: "4和9",
                .friday: "5和0"
            ]
        )
        let rule2 = TrafficRestrictionRule(
            startDate: date(from: "2025年6月30日")!,
            endDate: date(from: "2025年9月28日")!,
            restrictions: [
                .monday: "5和0",
                .tuesday: "1和6",
                .wednesday: "2和7",
                .thursday: "3和8",
                .friday: "4和9"
            ]
        )
        let rule3 = TrafficRestrictionRule(
            startDate: date(from: "2025年9月29日")!,
            endDate: date(from: "2025年12月28日")!,
            restrictions: [
                .monday: "4和9",
                .tuesday: "5和0",
                .wednesday: "1和6",
                .thursday: "2和7",
                .friday: "3和8"
            ]
        )
        let rule4 = TrafficRestrictionRule(
            startDate: date(from: "2025年12月29日")!,
            endDate: date(from: "2026年3月29日")!,
            restrictions: [
                .monday: "3和8",
                .tuesday: "4和9",
                .wednesday: "5和0",
                .thursday: "1和6",
                .friday: "2和7"
            ]
        )
        
        return [rule1, rule2, rule3, rule4]
    }()
    
    // 获取当前日期的限行信息
    public func getCurrentDateRestriction(currentDate: Date) -> String {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: currentDate) // 1=Sunday, 2=Monday, ..., 7=Saturday
        
        if let dayOfWeek = DayOfWeek(rawValue: weekday) {
            return getRestriction(for: dayOfWeek, on: currentDate).restriction
        }
        return "不限行"
    }
    
    // 获取未来一周的限行信息
    public func getNextWeekRestrictions(currentDate: Date) -> [DateRestriction] {
        var result: [DateRestriction] = []
        let calendar = Calendar.current
        var current = currentDate
        
        for _ in 0..<7 {
            let restriction = getRestriction(for: current)
            if !restriction.restriction.isEmpty {
                result.append(DateRestriction(date: formatDate(current), restriction: restriction.restriction))
            } else {
                result.append(DateRestriction(date: formatDate(current), restriction: "不限行"))
            }
            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }
        
        return result
    }
    
    // 根据日期获取限行信息
    private func getRestriction(for date: Date) -> (restriction: String, dateStr: String) {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        if let dayOfWeek = DayOfWeek(rawValue: weekday) {
            return getRestriction(for: dayOfWeek, on: date)
        }
        return ("不限行", formatDate(date))
    }
    
    // 根据星期几和日期获取限行信息
    private func getRestriction(for dayOfWeek: DayOfWeek, on date: Date) -> (restriction: String, dateStr: String) {
        for rule in rules {
            if date >= rule.startDate && date <= rule.endDate {
                if let restriction = rule.restrictions[dayOfWeek] {
                    return (restriction, formatDate(date))
                }
            }
        }
        return ("不限行", formatDate(date))
    }
    
    // 获取当前日期所在限行规则的详细信息
    public func getRestrictionDetails(for date: Date) -> (startDate: Date?, endDate: Date?, restriction: String, dayOfWeek: String) {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let dayOfWeekEnum = DayOfWeek(rawValue: weekday)
        
        for rule in rules {
            if date >= rule.startDate && date <= rule.endDate {
                if let restriction = rule.restrictions[dayOfWeekEnum!] {
                    return (rule.startDate, rule.endDate, restriction, dayOfWeekEnum!.description)
                }
            }
        }
        return (nil, nil, "不限行", dayOfWeekEnum?.description ?? "未知")
    }
    
    // 辅助函数：格式化日期为 "yyyy-MM-dd"
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    public func weekday(from date: Date) -> String {
       let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
       let weekdays = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
       return weekdays[components.weekday! - 1]
    }
}
