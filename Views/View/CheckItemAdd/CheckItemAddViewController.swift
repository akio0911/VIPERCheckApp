//
//  CheckItemAddViewController.swift
//  Views
//
//  Created by akio0911 on 2021/05/03.
//

import UIKit
import Presenter

final class CheckItemAddViewController: UIViewController {
    private let presenter: CheckItemAddPresenterInput

    @IBOutlet private weak var nameTextField: UITextField!

    init(presenter: CheckItemAddPresenterInput) {
        self.presenter = presenter

        super.init(
            nibName: "CheckItemAdd",
            bundle: Bundle(for: type(of: self))
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAddButton)
        )

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTapCancelButton)
        )
    }

    @objc private func didTapAddButton() {
        presenter.didTapAddButton()
    }

    @objc private func didTapCancelButton() {
        presenter.didTapCancelButton()
    }
}
