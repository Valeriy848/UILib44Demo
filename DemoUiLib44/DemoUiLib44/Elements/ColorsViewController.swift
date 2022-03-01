//
//  ColorsViewController.swift
//  DemoUiLib44
//
//  Created by Valeriy on 19.02.2022.
//

import UIKit
import UILib44

internal final class ColorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties

    private let allColors = CustomColors.allColors
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
        return allColors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath)
        let colorView: UIView = {
            let colorView = UIView(frame: CGRect(x: cell.frame.width - 40,
                                                 y: 10,
                                                 width: cell.frame.height - 20,
                                                 height: cell.frame.height - 20))
            colorView.backgroundColor = allColors[indexPath.row].color
            colorView.translatesAutoresizingMaskIntoConstraints = false
            return colorView
        }()

        cell.addSubview(colorView)
        cell.textLabel?.text = allColors[indexPath.row].name

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
