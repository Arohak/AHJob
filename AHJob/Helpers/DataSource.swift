//
//  DataSource.swift
//  AHJob
//
//  Created by Ara Hakobyan on 05/12/2017.
//  Copyright © 2017 Ara Hakobyan. All rights reserved.
//

import Foundation

protocol DataSource {
    
    func load(_ completionHandler: @escaping (NoteCollection) -> Void)
}

extension DataSource {
    
    func load(_ completionHandler: @escaping (NoteCollection) -> Void) {
        
    }
}

struct NoteCollection {
    
//    let dataSources = [localDataSource, iCloudDataSource, backendDataSource]

    init() {
        
    }
    
    func add() {
        print("added")
    }
}

//extension Array where Element: DataSource {
//    
//    func load(completionHandler: @escaping (NoteCollection) -> Void) {
//        let group = DispatchGroup()
//        let collection = NoteCollection()
//        
//        // De-duplicate the synchronization code by using a loop
//        for dataSource in self {
//            group.enter()
//            dataSource.load { notes in
//                collection.add(notes)
//                group.leave()
//            }
//        }
//        
//        group.notify(queue: .main) {
//            completionHandler(collection)
//        }
//    }
//}

