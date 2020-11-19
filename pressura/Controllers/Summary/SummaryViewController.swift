//
//  SummaryViewController.swift
//  pressura
//
//  Created by Sergio Diosdado on 18/10/20.
//

import UIKit
import Charts

class SummaryViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet weak var viewCollectionCards: UIView!
    @IBOutlet weak var pressureChart: LineChartUIView!
    @IBOutlet weak var weightAbdominalChart: LineChartUIView!
    @IBOutlet weak var drugsAttachmentChart: PieChartUIView!
    @IBOutlet weak var dietAttachmentChart: PieChartUIView!
    @IBOutlet weak var exerciseChart: PieChartUIView!
    
    
    var collectionPressureCards: UICollectionView?
    var bloodReadings: [BloodPressureReading] = []
    
    override func viewWillAppear(_ animated: Bool) {
        if bloodReadings.count == 0 {
            APIManager.shared.getBloodReadings{ (bloodReadings,message) in
                if let bReadings = bloodReadings {
                    self.bloodReadings = bReadings
                    self.collectionView.reloadData()
                }
            }
        }
        print()
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        print("frame width: ", self.view.frame.width)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "¡Hola!"
        pressureChart.backgroundColor = .red
        
        // Views From Components
        self.configureCollectionView()
        self.configureCharts()
        
        self.view.layoutIfNeeded()
    }
    func configureCharts(){
        // Line Charts
        pressureChart.setDataSetsPressures(systolicDataSet: sistolicP, diastolicDataSet: distolicP, pulseDataSet: pulses)
        weightAbdominalChart.setDataSetsMessures(weightDataSet: weight, abdominalLengthDataSet: abdominalLength)
        
        // Pie Charts
        drugsAttachmentChart.setInitValues(title: "Apego al medicamento")
        drugsAttachmentChart.setChartData(pieChartValues: exerciseValues)
        exerciseChart.setInitValues(title: "Apego a rutina de ejercicio")
        exerciseChart.setChartData(pieChartValues: exerciseValues)
        dietAttachmentChart.setInitValues(title: "Apego a la dieta")
        dietAttachmentChart.setChartData(pieChartValues: exerciseValues)
        
    }
    
    // Collection View - Pressure Cards config of collection view
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 19
        layout.minimumLineSpacing = 19
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PressureCardUIView.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    // Collection View - Add collectionView to view in superview, and constrains
    private func configureCollectionView() {
        viewCollectionCards.addSubview(collectionView)
        collectionView.backgroundColor = .white
        
        collectionView.topAnchor.constraint(equalTo: viewCollectionCards.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: viewCollectionCards.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: viewCollectionCards.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: viewCollectionCards.bottomAnchor).isActive = true

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // TODO: navigate to tableview with all pressures
    @IBAction func moreReadings(_ sender: UIButton) {
        APIManager.shared.getBloodReadings{ (bloodReadings,message) in
            if let bReadings = bloodReadings {
                self.bloodReadings = bReadings
            }
        }
        collectionView.reloadData()
    }
    
    // Collection View - Config of cells (Pressure card)
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 164, height: 164)
    }
    // Collection View - Config amount of cells (Pressure cards)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bloodReadings.count
    }
    // Collection View - Add data to each cell (Pressure card)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PressureCardUIView
        cell.configureCard(
            pSistolica: String(bloodReadings[indexPath.row].getSystolicReading()),
            pDiastolica: String(bloodReadings[indexPath.row].getDiastolicReading()),
            pulso: String(bloodReadings[indexPath.row].getPulse()))
        return cell
    }
    
    
    // Hardcodeado para pruebas gráficas....
    let pulses: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 60),
        ChartDataEntry(x: 2, y: 78),
        ChartDataEntry(x: 3, y: 55),
        ChartDataEntry(x: 4, y: 66),
        ChartDataEntry(x: 5, y: 78),
        ChartDataEntry(x: 6, y: 80),
        ChartDataEntry(x: 7, y: 60)
    ]
    let sistolicP: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 122),
        ChartDataEntry(x: 2, y: 139),
        ChartDataEntry(x: 3, y: 129),
        ChartDataEntry(x: 4, y: 119),
        ChartDataEntry(x: 5, y: 110),
        ChartDataEntry(x: 6, y: 130),
        ChartDataEntry(x: 7, y: 126)
    ]
    let distolicP: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 80),
        ChartDataEntry(x: 2, y: 82),
        ChartDataEntry(x: 3, y: 80),
        ChartDataEntry(x: 4, y: 78),
        ChartDataEntry(x: 5, y: 87),
        ChartDataEntry(x: 6, y: 85),
        ChartDataEntry(x: 7, y: 89)
    ]
    
    let weight: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 70),
        ChartDataEntry(x: 2, y: 73),
        ChartDataEntry(x: 3, y: 72),
        ChartDataEntry(x: 4, y: 70),
        ChartDataEntry(x: 5, y: 69),
        ChartDataEntry(x: 6, y: 72),
        ChartDataEntry(x: 7, y: 73)
    ]
    let abdominalLength: [ChartDataEntry] = [
        ChartDataEntry(x: 1, y: 76.2),
        ChartDataEntry(x: 2, y: 78),
        ChartDataEntry(x: 3, y: 77.5),
        ChartDataEntry(x: 4, y: 74.1),
        ChartDataEntry(x: 5, y: 74),
        ChartDataEntry(x: 6, y: 75),
        ChartDataEntry(x: 7, y: 75.3)
    ]
    
    let exerciseValues: [PieChartDataEntry] = [
        PieChartDataEntry(value: 10, label: "Deficiente"),
        PieChartDataEntry(value: 12, label: "Malo"),
        PieChartDataEntry(value: 20, label: "Aceptable"),
        PieChartDataEntry(value: 40, label: "Excelente")
    ]
    
}
