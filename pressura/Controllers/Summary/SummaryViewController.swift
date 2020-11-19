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
    
    var pulses: [ChartDataEntry] = []
    var sistolicP: [ChartDataEntry] = []
    var distolicP: [ChartDataEntry] = []
    
    var weight: [ChartDataEntry] = []
    var abdominalLength: [ChartDataEntry] = []
    
//    var drugsAttachemnt: [PieChartDataEntry] = []
    
    var collectionPressureCards: UICollectionView?
    var bloodReadings: [BloodPressureReading] = []
    
    override func viewWillAppear(_ animated: Bool) {
        if bloodReadings.count == 0 {
            APIManager.shared.getBloodReadings{ (bloodReadings,message) in
                if let bReadings = bloodReadings {
                    self.bloodReadings = bReadings
                    self.addBloodReadingsToGraphs()
                    self.configureCharts()
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
//        addBloodReadingsToGraphs()
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
        drugsAttachmentChart.setChartData(deficient: 10, bad: 20, acceptable: 40, excelent: 30)
        exerciseChart.setInitValues(title: "Apego a rutina de ejercicio")
        exerciseChart.setChartData(deficient: 1, bad: 22, acceptable: 30, excelent: 30)
        dietAttachmentChart.setInitValues(title: "Apego a la dieta")
        dietAttachmentChart.setChartData(deficient: 10, bad: 20, acceptable: 10, excelent: 40)
        
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
    
    
    // BloodPressure - add data to array
    func addBloodReadingsToGraphs() {
        for (index, bloodReading) in bloodReadings.enumerated() {
            print(index)
            let pulse = ChartDataEntry(x: Double(index), y:  Double(bloodReading.getPulse()))
            let sistolicPressure = ChartDataEntry(x: Double(index), y:  Double(bloodReading.getSystolicReading()))
            let diastolicPressure = ChartDataEntry(x: Double(index), y:  Double(bloodReading.getDiastolicReading()))
            pulses.append(pulse)
            sistolicP.append(sistolicPressure)
            distolicP.append(diastolicPressure)
        }
    }
    
}
