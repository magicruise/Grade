//
//  Student.swift
//  Grade
//
//  Created by LSMSE on 2017. 6. 7..
//  Copyright © 2017년 LSMSE. All rights reserved.
//

import Foundation

// creating model object from Values Extracted from JSON
struct Student {
    let name: String
    
    let average: Double
    var grade: String
    
    init(json: [String: Any]) throws {
        guard let name = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        
        guard let lectures = json["grade"] as? [String: Double] else {
            throw SerializationError.missing("grade")
        }
        
        for lecture in lectures {
            guard case (_, 0...100) = lecture else {
                throw SerializationError.invalid("score", lecture)
            }
        }
        
        self.name = name
        
        // 개인별 평균
        let sum = lectures.reduce(0) { $0 + $1.value }
        average = sum / Double(lectures.count)
        
        // 개인별 학점
        switch average {
        case 90...100: grade = "A"
        case 80 ..< 90: grade = "B"
        case 70 ..< 80: grade = "C"
        case 60 ..< 70: grade = "D"
        default: grade = "F"
        }
    }
}

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}
