//
//  AllFeedsScene.swift
//  NewsChallenge
//
//  Created by Dai Tran on 8/19/23.
//

import UIKit
import Combine

final class AllFeedsScene: UIViewController {
    private let vm: AddFeedsViewModelType
    private let dataSource: AllFeedsSceneDataSource
    private var subscriptions = Set<AnyCancellable>()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    init(vm: AddFeedsViewModelType, dataSource: AllFeedsSceneDataSource) {
        self.vm = vm
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableLayout()
        setupObservation()
        fetch()
    }
    
    private func setupTableLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.register(FeedCell.self, forCellReuseIdentifier: String(describing: FeedCell.self))
    }
    
    private func setupObservation() {
        vm.articles.receive(on: DispatchQueue.main).sink { [weak self] articles in
            self?.dataSource.update(items: articles)
            self?.tableView.reloadData()
        }
        .store(in: &subscriptions)
    }
    
    private func fetch() {
        Task {
            do {
                try await vm.fetch()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

final class AllFeedsSceneDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var items: [Article]
    private let didTapItem: ((Article) -> Void)
    
    init(items: [Article], didTapItem: @escaping (Article) -> Void) {
        self.items = items
        self.didTapItem = didTapItem
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: FeedCell.self),
            for: indexPath
        ) as? FeedCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row]
        cell.configure(with: FeedCell.Input(imageURL: item.imageUrl, title: item.title))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapItem(items[indexPath.row])
    }
    
    func update(items: [Article]) {
        self.items = items
    }
}
