//
//  History.swift
//  Hand-free-Recipe
//
//  Created by 李承紘 on 2021/6/2.
//

import Foundation


struct History{
    var data: [SearchRecord] = [SearchRecord(name: "Taco"),
                                SearchRecord(name: "Chicken and waffles")]
    var dataString: [String] = ["Taco","Chicken and waffles"]

    
    mutating func deleteHist(at record: SearchRecord){
        if let index = data.firstIndex(where: {$0 === record}){
            self.data.remove(at: index)
            self.dataString.remove(at: index)
        }
    }
    
    mutating func appendHist(at record: SearchRecord){
        if !self.dataString.contains(record.name){
            self.data.append(record)
            self.dataString.append(record.name)
        }
    }
}
