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
    
    var drugsAttachment: [Double] = Array(repeating: 0, count: 4)
    var dietAttachment: [Double] = Array(repeating: 0, count: 4)
    var excerciseAttachment: [Double] = Array(repeating: 0, count: 4)
    
    var collectionPressureCards: UICollectionView?
    var bloodReadings: [BloodPressureReading] = []
    var bloodReadingsCollectionView: [BloodPressureReading] = []
    var generalHealthReadings: [GeneralHealthReading] = []
    
    override func viewWillAppear(_ animated: Bool) {
        // Collection Pressure cards and Pressure Line Graph
        if bloodReadings.count == 0 {
            APIManager.shared.getBloodReadings{ (bloodReadings,message) in
                if let bReadings = bloodReadings {
                    self.bloodReadings = bReadings
                    let reversedBloodReadings: [BloodPressureReading] = Array(self.bloodReadings.reversed())
                    let sliceBloodReadings = reversedBloodReadings.prefix(5)
                    self.bloodReadingsCollectionView = Array(sliceBloodReadings)
                    self.collectionView.reloadData()
                    self.addBloodReadingsToGraphs()
                    self.configureBloodReadingsChart()
                }
            }
        }
        // Line graph for weight and circumference and pie charts graphs
        if generalHealthReadings.count == 0 {
            APIManager.shared.getGeneralHealthReadings{ (generalHealthReadings, message) in
                if let hReadings = generalHealthReadings {
                    self.generalHealthReadings = hReadings
                    self.addGeneralHealthReadingsToGraphs()
                    self.configureHealthReadingsChart()
                }
            }
        }
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "¡Bienvenido!"
        // Views From Components
        self.configureCollectionView()
        self.view.layoutIfNeeded()
    }
    
    func configureBloodReadingsChart() {
        // Line Charts
        pressureChart.setDataSetsPressures(systolicDataSet: sistolicP, diastolicDataSet: distolicP, pulseDataSet: pulses)
    }
    func configureHealthReadingsChart(){
       
        weightAbdominalChart.setDataSetsMessures(weightDataSet: weight, abdominalLengthDataSet: abdominalLength)
        
        // Pie Charts
        drugsAttachmentChart.setInitValues(title: "Apego al medicamento")
        drugsAttachmentChart.setChartData(deficient: drugsAttachment[0],
                                          bad: drugsAttachment[1],
                                          acceptable: drugsAttachment[2],
                                          excelent: drugsAttachment[3])
        exerciseChart.setInitValues(title: "Apego a rutina de ejercicio")
        exerciseChart.setChartData(deficient: excerciseAttachment[0],
                                   bad: excerciseAttachment[1],
                                   acceptable: excerciseAttachment[2],
                                   excelent: excerciseAttachment[3])
        dietAttachmentChart.setInitValues(title: "Apego a la dieta")
        dietAttachmentChart.setChartData(deficient: dietAttachment[0],
                                         bad: dietAttachment[1],
                                         acceptable: dietAttachment[2],
                                         excelent: dietAttachment[3])
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
        return bloodReadingsCollectionView.count
    }
    // Collection View - Add data to each cell (Pressure card)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PressureCardUIView
        cell.configureCard(
            pSistolica: String(bloodReadingsCollectionView[indexPath.row].getSystolicReading()),
            pDiastolica: String(bloodReadingsCollectionView[indexPath.row].getDiastolicReading()),
            pulso: String(bloodReadingsCollectionView[indexPath.row].getPulse()))
        return cell
    }
    
    
    // BloodPressure - add data to arrays
    func addBloodReadingsToGraphs() {
        for (index, bloodReading) in bloodReadings.enumerated() {
            let pulse = ChartDataEntry(x: Double(index), y:  Double(bloodReading.getPulse()))
            let sistolicPressure = ChartDataEntry(x: Double(index), y:  Double(bloodReading.getSystolicReading()))
            let diastolicPressure = ChartDataEntry(x: Double(index), y:  Double(bloodReading.getDiastolicReading()))
            pulses.append(pulse)
            sistolicP.append(sistolicPressure)
            distolicP.append(diastolicPressure)
        }
    }
    // Health readings - add data to arrays
    func addGeneralHealthReadingsToGraphs() {
        for (index, generalHealthReading) in generalHealthReadings.enumerated() {
            if let weightDouble = Double(generalHealthReading.getWeight()),
               let abdominalDouble = Double(generalHealthReading.getAbdominalCircumference()){
                let weightMessure = ChartDataEntry(x: Double(index), y: weightDouble)
                let abdominalMessure = ChartDataEntry(x: Double(index), y: abdominalDouble)
                weight.append(weightMessure)
                abdominalLength.append(abdominalMessure)
            }
            
            drugsAttachment[generalHealthReading.getTreatmentComplience()] += 1
            dietAttachment[generalHealthReading.getDietComplience()] += 1
            excerciseAttachment[generalHealthReading.getExerciseCompliance()] += 1
        }
    }
}
