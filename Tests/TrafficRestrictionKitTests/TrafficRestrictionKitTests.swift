// Tests/TrafficRestrictionKitTests/TrafficRestrictionKitTests.swift
import XCTest
@testable import TrafficRestrictionKit

final class TrafficRestrictionKitTests: XCTestCase {
    
    var manager: TrafficRestrictionManager!
    
    override func setUpWithError() throws {
        super.setUp()
        manager = TrafficRestrictionManager()
    }
    
    override func tearDownWithError() throws {
        manager = nil
        super.tearDown()
    }
    
    func testGetCurrentDateRestriction() throws {
        // Mock 当前日期为 2025-04-28 星期一
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: "2025-04-28") else {
            XCTFail("日期转换失败")
            return
        }
        
        let restriction = manager.getCurrentDateRestriction(currentDate: date)
        XCTAssertEqual(restriction, "1和6")
    }
    
    func testGetNextWeekRestrictions() throws {
        // Mock 当前日期为 2025-04-28 星期一
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let startDate = dateFormatter.date(from: "2025-04-28") else {
            XCTFail("日期转换失败")
            return
        }
        
        let restrictions = manager.getNextWeekRestrictions(currentDate: startDate)
        XCTAssertEqual(restrictions.count, 7)
        
        // 检查第一个日期的限行信息
        let firstDateFormatter = DateFormatter()
        firstDateFormatter.dateFormat = "yyyy-MM-dd"
        let firstDateString = firstDateFormatter.string(from: startDate)
        let firstRestriction = restrictions.first?.restriction
        
        // 2025-04-28 是星期一，限行规则为 "1和6"
        XCTAssertEqual(firstRestriction, "1和6")
    }
    
    func testGetRestrictionDetails() throws {
        // Mock 当前日期为 2025-04-28 星期一
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: "2025-04-28") else {
            XCTFail("日期转换失败")
            return
        }
        
        let (startDate, endDate, restriction, dayOfWeek) = manager.getRestrictionDetails(for: date)
        XCTAssertNotNil(startDate)
        XCTAssertNotNil(endDate)
        XCTAssertEqual(restriction, "1和6")
        XCTAssertEqual(dayOfWeek, "星期一")
    }
}
