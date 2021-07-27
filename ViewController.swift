//
//  ViewController.swift
//  NewsAPI
//
//  Created by Adrian Suryo Abiyoga on 27/07/21.
//

import UIKit
import SafariServices
//table view
//custom cell
//api caller

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableView.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    private var searchVC = UISearchController(searchResultsController: nil)
    private var articles = [Articles]()
    private var viewModels = [NewsTableViewCellViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        
       fetchTopStories()
        createSearchBar()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func createSearchBar(){
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    private func fetchTopStories(){
        APICaller.shared.getTopStories{ [weak self] result in
        switch result{
        case .success(let articles):
            self?.articles = [Articles]()
            self?.viewModels = articles.compactMap({
                NewsTableViewCellViewModel(title: $0.title, subtitle: $0.description ?? "No description", imageURL: URL(string: $0.urlToImage ?? ""))
            })
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            break
        case .failure(let error):
            print(error)
        }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,
                                                 for: indexPath
        ) as? NewsTableViewCell else {
                fatalError()
            }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let articles = articles[indexPath.row]
        
        guard let url = URL(string: articles.url ?? "") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        APICaller.shared.search(with: text){ [weak self] result in
            switch result{
            case .success(let articles):
                self?.articles = [Articles]()
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title, subtitle: $0.description ?? "No description", imageURL: URL(string: $0.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.searchVC.dismiss(animated: true, completion: nil)
                }
                break
            case .failure(let error):
                print(error)
            }
            }
        print(text)
    }
}

