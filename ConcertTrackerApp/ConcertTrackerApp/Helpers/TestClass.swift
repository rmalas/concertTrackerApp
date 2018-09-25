//
//  TestClass.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasniak on 8/28/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

class ClassA {
    let firstField: String
    let secondField: String
    
    init(firstField: String,secondField: String) {
        self.firstField = firstField
        self.secondField = secondField
    }
}

class ClassB: ClassA {
    let thirdField: String
    
    init(thirdField: String,secondField: String,firstField: String) {
        self.thirdField = thirdField
        super.init(firstField: firstField, secondField: secondField)
    }
}
