//
//  FileController.swift
//  Grade
//
//  Created by LSMSE on 2017. 6. 7..
//  Copyright © 2017년 LSMSE. All rights reserved.
//

import Foundation

struct FileController {
    
    // 사용자 홈 디렉터리의 students.json 파일 읽기
    func readJsonFile() -> [[String: Any]]? {
        let jsonFile = URL(fileURLWithPath: NSHomeDirectory() + "/students.json")
        
        guard let data = try? Data(contentsOf: jsonFile),
            let json = try? JSONSerialization.jsonObject(with: data, options:[]) as? [[String: Any]]
            else {
                print("Cannot read a json file")
                return nil
        }
        return json
    }
    
    // 사용자 홈 디렉터리에 result.txt 생성하여 출력 (UTF-8 인코딩: String..utf8)
    func writeTextFile(WithStringArray stringsForWrite: [String]) {
        let textFile = NSHomeDirectory() + "/result.txt"
        
        let firstString = "성적결과표"
        
        guard ((try? firstString.write(toFile: textFile, atomically: false, encoding: .utf8)) != nil),
            let fileHandle = FileHandle(forWritingAtPath: textFile) else {
                print("Cannot create a text file")
                return
        }
        
        for string in stringsForWrite {
            guard let data = string.data(using: .utf8, allowLossyConversion: false) else {
                print("Cannot convert string to data")
                return
            }
            
            fileHandle.seekToEndOfFile()
            fileHandle.write(data)
        }
        fileHandle.closeFile()
    }
}
