////
////  DBandRequestManager.swift
////  ConcertTrackerApp
////
////  Created by Roman Malasnyak on 5/22/18.
////  Copyright © 2018 Roman Malasnyak. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//
////class Future<T> {
////    func onSuccess(_ completion: (T) -> Void) -> Future<T>
////    func `catch`(_ completion: (Error) -> Void)
////}
////
////protocol DataManagerProtocol {
////    func getArtist(name: String) -> Future<Artist>
////}
////
////
////DataManagerProtocol().getArtt("sddsd").onSuccess{
//
////    }.catch { errroi on
////
////}
////
////
////protocol DataManagerProtocol {
////    func getArtist(name: String, _ completion: ([Artist]) -> Void)
////}
////
////class RequestManager1: DataManagerProtocol {
////    func getArtist(name: String, _ completion: ([Artist]) -> Void) {
////
////    }
////
////}
////
////class DBandRequestManager: DataManagerProtocol {
////    private let requestManager: DataManagerProtocol = RequestManager1()
////
////    func getArtist(name: String, _ completion: ([Artist]) -> Void) {
////        if as
////    }
////}
////
////class VC {
////    let dataSource: DataManagerProtocol = RequestManager1()
////}
//
//
//class DBandRequestManager {
//    private let requestManager = RequestManager()
//    private lazy var realm = try! Realm()
//
//    func isInCache<T: Object>(_ type: T.Type) -> Bool {
//        return try! Realm().objects(type).count > 0
//    }
//
//    func getObjects<T: Object>(_ type: T.Type, _ dataSource: @escaping  (([T]) -> Void)->Void, _ completion: ([T]) -> Void) {
//        if isInCache(T.self) {
//            let objects = Array(realm.objects(T.self))
//            completion(objects)
//        } else {
//            dataSource{ objects in
////                realm.write {
////
////                }
//                completion(objects)
//            }
//        }
//    }
//
//    func getArtists(_ completion: ([Artist]) -> Void) {
//        getObjects(Event.self, <#T##dataSource: (([T]) -> Void) -> Void##(([T]) -> Void) -> Void#>, <#T##completion: ([T]) -> Void##([T]) -> Void#>)
//        getObjects(Artist.self, {
//            requestManager.getDataWithCityName(name: "")
//        }, completion)
//    }
//
//    func getDataFromNetwork() {
//
//    }
//
//    func getDataFromLocalDB() {
//
//    }
//
//    func getData() {
//
//    }
//
//}
