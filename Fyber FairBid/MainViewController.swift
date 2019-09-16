//
//  ViewController.swift
//  Fyber FairBid
//
//  Created by Nikita on 24/03/2019.
//  Copyright © 2019 Fyber. All rights reserved.
//

import UIKit

enum ObjectTypes: String, CaseIterable {
    case interstitial = "Interstitial"
    case rewarded = "Rewarded"
    case banner = "Banner"
    case emptyCell = ""
    case testSuite = "Test Suite"
}

class HeadlineTableViewCell: UITableViewCell {
    @IBOutlet weak var unitImage: UIImageView!
    @IBOutlet weak var unitLabel: UILabel!
}

class ViewController: UIViewController {

    @IBOutlet weak var adUnitsTable: UITableView!
    @IBOutlet weak var versionLabel: UILabel!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        adUnitsTable.tableFooterView = (UIView(frame: CGRect.zero))
        versionLabel.text = "Fyber FairBid " + FairBid.version()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            cell.backgroundColor = view.backgroundColor
        } else {
            cell.backgroundColor = .white
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 40
        } else {
            return 80
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "select ad", let adVC = segue.destination as? AdsScreenViewController {

            if let indexPath = adUnitsTable.indexPathForSelectedRow {
                if indexPath.row >= 0 && indexPath.row <= 2 {
                    adVC.adType = ObjectTypes.allCases[indexPath.row]
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            FairBid.presentTestSuite()
        }
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = ObjectTypes.allCases[indexPath.row].rawValue

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier(at: indexPath), for: indexPath) as! HeadlineTableViewCell
        var image = UIImage()

        cell.unitLabel?.text = text
        cell.unitLabel.sizeToFit()
        if indexPath.row == 0 {
            image = UIImage(named: ObjectTypes.allCases[indexPath.row].rawValue)!
        } else if indexPath.row == 1 {
            image = UIImage(named: ObjectTypes.allCases[indexPath.row].rawValue)!
        } else if indexPath.row == 2 {
            image = UIImage(named: ObjectTypes.allCases[indexPath.row].rawValue)!
        } else if indexPath.row == 3 {
            cell.unitLabel?.text = ""
            cell.unitImage.image = nil
            cell.accessoryType = .none
            cell.isUserInteractionEnabled = false
        } else if indexPath.row == 4 {
            image = UIImage(named: ObjectTypes.allCases[indexPath.row].rawValue)!
        }

        cell.unitImage.image = image
        return cell
    }

    private func identifier(at indexPath: IndexPath) -> String {
        if indexPath.row == 4 {
            return "Test Suite Cell"
        } else {
            return "Ad Cell"
        }
    }

}
