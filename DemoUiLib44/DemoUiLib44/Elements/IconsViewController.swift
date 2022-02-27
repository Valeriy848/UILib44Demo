//
//  IconsViewController.swift
//  DemoUiLib44
//
//  Created by Valeriy on 20.02.2022.
//

import UIKit
import UILib44

internal final class IconsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties

    private let allIcons = CustomIcons.allImages
    private let cellID = "Cell"

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        tableView.dataSource = self

        setupUI()
    }

    // MARK: - UI

    private func setupUI() {
        view.backgroundColor = CustomColors.levelZero.color

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allIcons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath)
        let imagerView: UIImageView = {
            let imagerView = UIImageView(frame: CGRect(x: cell.frame.width - 40, y: 10, width: 24, height: 24))
            imagerView.image = allIcons[indexPath.row].image
            imagerView.translatesAutoresizingMaskIntoConstraints = false
            return imagerView
        }()

        cell.addSubview(imagerView)
        cell.textLabel?.text = allIcons[indexPath.row].name

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
