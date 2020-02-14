//
//  LocationViewController.swift
//  WeatherProject
//
//  Created by Thanh Nguyen on 2/10/20.
//  Copyright © 2020 Thanh Nguyen. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var locations: [WLocation] = []
    
    @IBOutlet weak var contentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    func setupTableView() {
        contentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        locations = DataBaseManger.loadAllLocationDB()
        contentTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("city_title", comment: "")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = locations[indexPath.row].name
        
        let location = locations[indexPath.row]
        if location.isSelected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if locations[indexPath.row].isSelected {
            var selectedCount = 0
            for location in locations {
                if location.isSelected {
                    selectedCount += 1
                }
            }
            
            if selectedCount > 1 {
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if locations[indexPath.row].isSelected {
            var selectedCount = 0
            for location in locations {
                if location.isSelected {
                    selectedCount += 1
                }
            }
            
            if selectedCount > 1 {
                locations[indexPath.row].isSelected = false
            }
        } else {
            locations[indexPath.row].isSelected = true
        }
        
    }
    

    // MARK: - Actions
    @IBAction func backButtonAction(_ sender: Any) {
        DataBaseManger.updateLocationDB(locations: locations)
        
        dismiss(animated: true) {
            let noti = NotificationCenter.default
            noti.post(name: Notification.Name(Keys.LocationDidSelectedKey), object: nil)
        }
    }
}
