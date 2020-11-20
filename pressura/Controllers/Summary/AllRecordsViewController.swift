//
//  AllRecordsViewController.swift
//  pressura
//
//  Created by Julio Gutierrez Briones on 19/11/20.
//

import Foundation
import UIKit

class AllRecordsViewController: UIViewController, UITableViewDelegate {
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()

    var AllBloodReadings = [BloodPressureReading]()
    var formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mis mediciones"
        view.backgroundColor = .white
        refreshControl.addTarget(self, action: #selector(refreshReadings(_:)), for: .valueChanged)
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        //tableView.largeContentTitle = "Mis mediciones"
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        

    }
    
    @objc func refreshReadings(_ sender: Any){
        APIManager.shared.getBloodReadings{ (bloodReadings,message) in
            if let bReadings = bloodReadings {
                self.AllBloodReadings = bReadings.reversed()
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }

}


extension AllRecordsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllBloodReadings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let createdDate = AllBloodReadings[indexPath.row].getCreationDate()
        //let dateFormatted = createdDate.index(createdDate.startIndex, offsetBy: 16)
        
        cell.creationDate.text = String(createdDate.prefix(16))
        cell.diastolicReading.text = String(AllBloodReadings[indexPath.row].getDiastolicReading())
        cell.sistolicReading.text = String(AllBloodReadings[indexPath.row].getSystolicReading())
        cell.pulseReading.text = String(AllBloodReadings[indexPath.row].getPulse())
        
        return cell
    }
    
}

