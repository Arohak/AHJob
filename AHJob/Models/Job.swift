//
//  Job.swift
//

import Foundation

struct Job {
    
    var title = ""
    var company = ""
    var description = ""
    var src = ""
    var info = ""
    
    var url: URL? {
        return URL(string: src)
    }
}
