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
    
    func addDataToChart(pieChartValues: [PieChartDataEntry], colors: [UIColor]){
        let dataSet = PieChartDataSet(entries: pieChartValues, label: nil)
        dataSet.colors = colors
        dataSet.valueColors = [.black]
        dataSet.selectionShift = 0
        dataSet.drawValuesEnabled = true
        dataSet.drawIconsEnabled = false
        let data = PieChartData(dataSet: dataSet)
        
        pieChartView.data = data
        pieChartView.notifyDataSetChanged()
    }
    
    func setChartData(deficient: Double, bad: Double, acceptable: Double, excelent: Double) {
        var colorsArr: [UIColor] = []
        var piechartData: [PieChartDataEntry] = []
        
        if deficient > 0 {
            piechartData.append(PieChartDataEntry(value: deficient, label: "Deficiente"))
            colorsArr.append(#colorLiteral(red: 0.9725490196, green: 0.3215686275, blue: 0.3254901961, alpha: 1))
        }
        if bad > 0 {
            piechartData.append(PieChartDataEntry(value: bad, label: "Malo"))
            colorsArr.append(#colorLiteral(red: 0.9960784314, green: 0.8980392157, blue: 0.5137254902, alpha: 1))
        }
        if acceptable > 0 {
            piechartData.append(PieChartDataEntry(value: acceptable, label: "Aceptable"))
            colorsArr.append(#colorLiteral(red: 0.3254901961, green: 0.5490196078, blue: 0.9411764706, alpha: 1))
        }
        if excelent > 0 {
            piechartData.append(PieChartDataEntry(value: excelent, label: "Excelente"))
            colorsArr.append(#colorLiteral(red: 0.3450980392, green: 0.768627451, blue: 0.4431372549, alpha: 1))
        }
    
        self.addDataToChart(pieChartValues: piechartData, colors: colorsArr)
    }
}
