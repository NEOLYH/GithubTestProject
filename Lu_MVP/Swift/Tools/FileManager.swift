//
//  File.swift
//  Swift
//
//  Created by apple on 2019/1/8.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class FileManager:NSObject {
    
   static func reccommandedData() -> [String: Any]? {
        return  readFileWithName("Recommanded")
    }
    
    private func readFileWithName(_ name:String) ->[String:Any]? {
        
        let file = Bundle.main.path(forResource: name, ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: file!))
        let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
        return jsonData
    }
    
}
