// Sources/TrafficRestrictionKit/DateRestriction.swift
import Foundation

public struct DateRestriction: Identifiable {
    public let id = UUID()
    public let date: String
    public let restriction: String
    
    public init(date: String, restriction: String) {
        self.date = date
        self.restriction = restriction
    }
}
