//
//  JobsViewController.swift
//  AHJob
//
//  Created by Ara Hakobyan on 26/11/2017.
//  Copyright © 2017 Ara Hakobyan. All rights reserved.
//

import UIKit

final class JobsViewController: UIViewController {
    
    typealias Cell = CustomCell
    fileprivate var jobs: [Job] = []
    fileprivate var tuple = (keywoerd: "ios", page: 1, limit: 10, loading: false)
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
}

extension JobsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        fetchJobs()
    }
    
    private func setupTableView() {
        tableView.register(cellType: Cell.self)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.keyboardDismissMode = .onDrag
    }
    
    private func fetchJobs(with keywoerd: String = "ios") {
        tuple = (keywoerd: keywoerd, page: 1, limit: 10, loading: false)
        jobs = HTTPHelper.fetchJobs(with: tuple.keywoerd, page: tuple.page)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension JobsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            GCDHelper.cancel()
            jobs.removeAll()
            tableView.reloadData()
            return
        }

        GCDHelper.requestWorkItem {
            self.fetchJobs(with: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query = searchBar.text ?? ""
        if !query.isEmpty {
            fetchJobs(with: query)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension JobsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: Cell.self)
        let job = jobs[indexPath.row]
        cell.setup(item: job)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let job = jobs[indexPath.row]
        if let url = job.url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension JobsViewController {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        loadMore(index: indexPath.row)
    }
    
    private func loadMore(index: Int) {
        if !tuple.loading && index == tuple.limit - 1 {
            tuple.page += 1
            tuple.limit += 10
            tuple.loading = true
            
            DispatchQueue.global(qos: .userInitiated).async {
                let fetchJobs = HTTPHelper.fetchJobs(with: self.tuple.keywoerd, page: self.tuple.page)
                DispatchQueue.main.async {
                    self.tuple.loading = false
                    self.jobs += fetchJobs
                    self.tableView.reloadData()
                }
            }
        }
    }
}
