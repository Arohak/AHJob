 //
 //  GCDHelper.swift
 //  AHJob
 //
 //  Created by Ara Hakobyan on 05/12/2017.
 //  Copyright © 2017 Ara Hakobyan. All rights reserved.
 //
 
 import Foundation
 
 class GCDHelper {
    
    // We keep track of the pending work item as a property
    fileprivate static var pendingRequestWorkItem: DispatchWorkItem?
 }
 
 extension GCDHelper {
    
    static func requestWorkItem(completionHandler: @escaping () -> ()) {
        // Cancel the currently pending item
        cancel()
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem {
            completionHandler()
        }
        // Save the new work item and execute it after 250 ms
        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(250), execute: requestWorkItem)
    }

    static func cancel() {
        pendingRequestWorkItem?.cancel()
    }
 }
 
// class DispatchGroupHelper {
//    // First, we create a group to synchronize our tasks
//    var xxx = DispatchGroup()
//    
//    // NoteCollection is a thread-safe collection class for storing notes
//    let collection = NoteCollection()
//    
//    // The 'enter' method increments the group's task count…
//    group.enter()
//    localDataSource.load { notes in
//    collection.add(notes)
//    // …while the 'leave' methods decrements it
//    group.leave()
//    }
//    
//    group.enter()
//    iCloudDataSource.load { notes in
//    collection.add(notes)
//    group.leave()
//    }
//    
//    group.enter()
//    backendDataSource.load { notes in
//    collection.add(notes)
//    group.leave()
//    }
//    
//    // This closure will be called when the group's task count reaches 0
//    group.notify(queue: .main) { [weak self] in
//    self?.render(collection)
//    }
// }

