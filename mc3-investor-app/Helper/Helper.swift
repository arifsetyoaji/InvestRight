//
//  Helper.swift
//  mc3-investor-app
//
//  Created by Jeffry Steward W on 14/07/20.
//  Copyright © 2020 Jeffry Steward W. All rights reserved.
//

import Foundation

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}

extension Date {
    var monday: Date? {
        
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    var tuesday: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 2, to: sunday)
    }
    var wednesday: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 3, to: sunday)
    }
    var thursday: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 4, to: sunday)
    }
    var friday: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 5, to: sunday)
    }
    var saturday: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 6, to: sunday)
    }
    var sunday: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
}

func dateFormatter() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd yyyy"
    return dateFormatter.string(from: Date())
}


class Helper {
    func saveLesson(lesson: Lesson, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(lesson) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }

    func getLesson(key: String) -> Lesson? {
        let defaults = UserDefaults.standard
        if let savedLessons = defaults.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let decodedLesson = try? decoder.decode(Lesson.self, from: savedLessons) {
                return decodedLesson
            }
        }
        return nil
    }

}
