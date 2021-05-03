//
//  CheckItemListViewController.swift
//  Views
//
//  Created by akio0911 on 2021/05/02.
//

import UIKit
import Domain
import Presenter

// ViewController は public ではないため、Router からのみインスタンス化できる
final class CheckItemListViewController: UIViewController {
    private let presenter: CheckItemListPresenterInput

    private var dataSource: [CheckItem] = []

    @IBOutlet private weak var tableView: UITableView!

    init(presenter: CheckItemListPresenterInput) {
        self.presenter = presenter
        super.init(
            nibName: "CheckItemList",
            bundle: Bundle(for: type(of: self))
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        presenter.updateView()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton)
        )
    }

    @objc private func didTapAddButton() {
        presenter.didTapAddButton()
    }

    func reload() {
        presenter.reload()
    }
}

extension CheckItemListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].name
        return cell
    }
}

extension CheckItemListViewController: CheckItemListViewInterface {
    func showCheckItems(checkItems: [CheckItem]) {
        dataSource = checkItems
        tableView.reloadData()
    }

    func showErrorScreen() {
        dataSource = []
        tableView.reloadData()
    }

    func showNoContentScreen() {
        dataSource = []
        tableView.reloadData()
    }
}
