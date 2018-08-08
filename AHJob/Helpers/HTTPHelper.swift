//
//  HTTPHelper.swift
//

import SwiftSoup

struct HTTPHelper {
    
    static var baseUrl      = "http://jobspider.am"
    static var searchUrl    = "http://jobspider.am/Jobs/Search?q=%@&page=%i"
//    static var searchUrl    = "http://ijob.am/job-list/?search_keywords=%@"

    static func fetchJobs(with query: String, page: Int) -> [Job] {
        let urlString = String(format: searchUrl, query, page)
        guard let myURL = URL(string: urlString) else {
            return []
        }
        
        do {
            let html = try String(contentsOf: myURL, encoding: .utf8)
            return parseHtmlContent(html)
        } catch {
            print("can't parse")
        }
        
        return []
    }
    
    static func fetchJobs(with query: String) -> [Job] {
        let urlString = String(format: searchUrl, query)
        guard let myURL = URL(string: urlString) else {
            return []
        }
        
        do {
            let html = try String(contentsOf: myURL, encoding: .utf8)
            return parseHtmlContent(html)
        } catch {
            print("can't parse")
        }
        
        return []
    }
    
    static func parseHtmlContent(_ html: String) -> [Job] {
        var temp = [Job]()
        
        let doc: Document = try! SwiftSoup.parseBodyFragment(html)
        let body = doc.body()
        
        do {
            if let jobs = try body?.getElementsByClass("job") {
                for job in jobs {
//                    let href = try! job.select("a").first()?.attr("href")
                    var href = ""
                    do {
                        href = try job.select("a[href]").attr("href")
                        href = baseUrl + href
                    } catch {
                        print("no href")
                    }
                    
                    var title = ""
                    do {
                        title = try job.select("a").first()?.text() ?? ""
                    } catch {
                        print("no title")
                    }
                    
                    var company = ""
                    do {
                        company = try job.getElementsByClass("comp").first()?.select("li").text() ?? ""
                    } catch {
                        print("no company")
                    }
                    
                    var descr = ""
                    do {
                        descr = try job.getElementsByClass("descr").first()?.select("li").text() ?? ""
                    } catch {
                        print("no descriction")
                    }
                    
                    var info = ""
                    do {
                        info = try job.getElementsByClass("src").first()?.select("li").text() ?? ""
                    } catch {
                        print("no url")
                    }
                    
                    let job = Job(title: title, company: company, description: descr, src: href, info: info)
                    temp.append(job)
                    
//                    print("\n\n\(String(describing: title))\n\(String(describing: company))\n\(String(describing: descr))\n\(String(describing: info))")
                }
            }
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print("error")
        }
        
        return temp
    }
}
