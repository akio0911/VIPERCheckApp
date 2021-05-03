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

    private var addButton: UIBarButtonItem!
    private var cancelButton: UIBarButtonItem!

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

        addButton = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapAddButton)
        )
        addButton.isEnabled = false
        navigationItem.rightBarButtonItem = addButton

        cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didTapCancelButton)
        )
        navigationItem.leftBarButtonItem = cancelButton
    }

    @objc private func didTapAddButton() {
        presenter.didTapAddButton(name: nameTextField.text ?? "")
    }

    @objc private func didTapCancelButton() {
        presenter.didTapCancelButton()
    }

    @IBAction func didChangeNameTextField(_ sender: Any) {
        presenter.didChangeNameTextField(name: nameTextField.text ?? "")
    }
}

extension CheckItemAddViewController: CheckItemAddViewInterface {
    func enableSaveButton(isEnabled: Bool) {
        addButton.isEnabled = isEnabled
    }
}
