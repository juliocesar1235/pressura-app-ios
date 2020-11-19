//
//  PieChartUIView.swift
//  pressura
//
//  Created by Raúl Castellanos on 15/11/20.
//

import UIKit
import Charts

final class PieChartUIView: UIView {
    
    @IBOutlet private weak var viewComponent: UIView!
    let pieChartView: PieChartView  = {
        let chartView = PieChartView()
        chartView.backgroundColor = .white
        // chartView.animate(xAxisDuration: 0.5)
        chartView.chartDescription?.textColor = #colorLiteral(red: 0.3058823529, green: 0.3098039216, blue: 0.3058823529, alpha: 1)
        chartView.holeRadiusPercent = 0.3
        chartView.transparentCircleRadiusPercent = 0
        chartView.drawEntryLabelsEnabled = false
        
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
        self.addSubview(view)
        self.configureChart()
    }
    
    private func configureChart(){
        viewComponent.addSubview(pieChartView)
        pieChartView.translatesAutoresizingMaskIntoConstraints = true
        
        pieChartView.frame.size.height = viewComponent.frame.height
        NSLayoutConstraint.activate([
            pieChartView.centerYAnchor.constraint(equalTo: viewComponent.centerYAnchor),
            pieChartView.centerXAnchor.constraint(equalTo: viewComponent.centerXAnchor)
        ])
    }
    
    func setInitValues(width: CGFloat, chartTitle: String){
        viewComponent.frame.size.width = width
        pieChartView.frame.size.width = viewComponent.frame.width
        pieChartView.chartDescription?.text = chartTitle
        pieChartView.reloadInputViews()
    }
    
    func setChartData(pieChartValues: [PieChartDataEntry]){
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
}
