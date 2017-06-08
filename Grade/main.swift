//
//  main.swift
//  Grade
//
//  Created by LSMSE on 2017. 6. 7..
//  Copyright © 2017년 LSMSE. All rights reserved.
//

import Foundation

// 파일 입출력
let fileController = FileController()
// 학생들
var students: [Student] = []
// 출력 String 배열
var stringsForWrite: [String] = []

// json 파일 읽기
if let json = fileController.readJsonFile() {
    for object in json {
        students.append(try Student(json: object))
    }
}

// 전체 평균 : 소수점 둘째자리까지
let sum = students.reduce(0) {$0 + $1.average}
let allAverage =  (sum / Double(students.count) * 100).rounded() / 100

stringsForWrite.append("\n\n전체 평균 : " + String(allAverage))

// 개인별 학점 내림차순
students.sort { $0.name < $1.name }

stringsForWrite.append("\n\n개인별 학점")
for student in students {
    var string = String.init(repeating: " ", count: 11-student.name.characters.count)
    string.insert(contentsOf: "\n\(student.name)".characters, at: string.startIndex)
    string.insert(contentsOf: ": \(student.grade)".characters, at: string.endIndex)
    stringsForWrite.append(string)
}

// 수료생 : 평균 70점 이상, 내림차순

var string = ""

let completedStudents = students.filter { $0.average >= 70 }

if completedStudents.capacity > 0 {
    var namesOfCompletedStudents = completedStudents.map { "\($0.name)" }.sorted { $0 < $1 }
    
    string = namesOfCompletedStudents.remove(at: 0)
    for student in namesOfCompletedStudents {
        string += ", \(student)"
    }
} else {
    string = "Cannot find any completed students"
}

stringsForWrite.append("\n\n수료생\n")
stringsForWrite.append(string)

// result 파일 쓰기
fileController.writeTextFile(WithStringArray: stringsForWrite)
