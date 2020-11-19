//
//  PieChartUIView.swift
//  pressura
//
//  Created by Raúl Castellanos on 15/11/20.
//

import UIKit
import Charts

final class PieChartUIView: UIView {
    
    @IBOutlet weak var chartTitle: UILabel!
    @IBOutlet private weak var viewComponent: UIView!
    let pieChartView: PieChartView  = {
        let chartView = PieChartView()
        chartView.chartDescription?.textColor = #colorLiteral(red: 0.3058823529, green: 0.3098039216, blue: 0.3058823529, alpha: 1)
        chartView.holeRadiusPercent = 0.3
        chartView.transparentCircleRadiusPercent = 0
        chartView.drawEntryLabelsEnabled = false
        chartView.usePercentValuesEnabled = false
        
        let chartLegent = chartView.legend
        chartLegent.textColor = #colorLiteral(red: 0.3058823529, green: 0.3098039216, blue: 0.3058823529, alpha: 1)
        chartLegent.orientation = .vertical
        chartLegent.verticalAlignment = .center
        
        return chartView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        configureView()
    }
    
    private func configureView(){
        guard let view = self.loadViewFromNib(nibName: "PieChartComponent")
            else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        self.configureChart()
    }
    
    private func configureChart(){
        viewComponent.addSubview(pieChartView)
    
        pieChartView.frame.size.width = viewComponent.frame.width
        pieChartView.frame.size.height = viewComponent.frame.height
        pieChartView.topAnchor.constraint(equalTo: viewComponent.topAnchor).isActive = true
        pieChartView.leadingAnchor.constraint(equalTo: viewComponent.leadingAnchor).isActive = true
        pieChartView.trailingAnchor.constraint(equalTo: viewComponent.trailingAnchor).isActive = true
        pieChartView.bottomAnchor.constraint(equalTo: viewComponent.bottomAnchor).isActive = true
        pieChartView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func setInitValues(title: String){
        chartTitle.text = title
        pieChartView.reloadInputViews()
    }
    
    func addDataToChart(pieChartValues: [PieChartDataEntry]){
        let dataSet = PieChartDataSet(entries: pieChartValues, label: nil)
        dataSet.colors = [#colorLiteral(red: 1, green: 0.2078431373, blue: 0.2352941176, alpha: 1), #colorLiteral(red: 0.9803921569, green: 0.568627451, blue: 0.2117647059, alpha: 1), #colorLiteral(red: 0.2117647059, green: 0.2745098039, blue: 0.9803921569, alpha: 1), #colorLiteral(red: 0.1568627451, green: 0.6509803922, blue: 0.137254902, alpha: 1)]
        dataSet.valueColors = [.white]
        dataSet.selectionShift = 0
        dataSet.drawValuesEnabled = true
        dataSet.drawIconsEnabled = false
        let data = PieChartData(dataSet: dataSet)
        
        pieChartView.data = data
        pieChartView.notifyDataSetChanged()
    }
    
    func setChartData(deficient: Double, bad: Double, acceptable: Double, excelent: Double) {
        var piechartData: [PieChartDataEntry] = []
        piechartData.append(PieChartDataEntry(value: deficient, label: "Deficiente"))
        piechartData.append(PieChartDataEntry(value: bad, label: "Malo"))
        piechartData.append(PieChartDataEntry(value: acceptable, label: "Aceptable"))
        piechartData.append(PieChartDataEntry(value: excelent, label: "Excelente"))
        
        self.addDataToChart(pieChartValues: piechartData)
    }
}
