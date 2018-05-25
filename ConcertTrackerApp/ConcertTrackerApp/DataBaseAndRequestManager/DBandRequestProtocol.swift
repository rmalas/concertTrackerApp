//
//  DBandRequestProtocol.swift
//  ConcertTrackerApp
//
//  Created by Roman Malasnyak on 5/22/18.
//  Copyright © 2018 Roman Malasnyak. All rights reserved.
//

import Foundation

protocol DBandRequestProtocol {
    
    func getDataFromNetwork()
    
    func getDataFromLocalDB()
    
    func getData()
    
}
