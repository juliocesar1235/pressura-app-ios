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

    var AllBloodReadings = [BloodPressureReading]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        setupTableView()
    }
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.largeContentTitle = "Mis mediciones"
        //tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        

    }
}

extension AllRecordsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllBloodReadings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        //let formatter = DateFormatter()
        //formatter.dateStyle = .short
        cell.creationDate.text =  AllBloodReadings[indexPath.row].getCreationDate().sp
        cell.diastolicReading.text = String(AllBloodReadings[indexPath.row].getDiastolicReading())
        cell.sistolicReading.text = String(AllBloodReadings[indexPath.row].getSystolicReading())
        cell.pulseReading.text = String(AllBloodReadings[indexPath.row].getPulse())
        return cell
    }
    
}
