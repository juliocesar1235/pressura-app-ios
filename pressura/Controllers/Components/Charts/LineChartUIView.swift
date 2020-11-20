//
//  LineChartUIView.swift
//  pressura
//
//  Created by Raúl Castellanos on 14/11/20.
//

import UIKit
import Charts

final class LineChartUIView: UIView, ChartViewDelegate {
    @IBOutlet private weak var viewComponent: UIView!
    @IBOutlet weak var marker: UILabel!
    
    let markerView = MarkerView()
    let colors: [UIColor] = [
        #colorLiteral(red: 0, green: 0, blue: 0.8392156863, alpha: 1),
        #colorLiteral(red: 0, green: 0.831372549, blue: 0.831372549, alpha: 1),
        #colorLiteral(red: 1, green: 0.5019607843, blue: 0, alpha: 1)
    ]
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
//        chartView.backgroundColor = .white
        chartView.animate(xAxisDuration: 0.5)
        chartView.rightAxis.enabled = false
        chartView.drawMarkers = true
        
        let chartLegend = chartView.legend
        chartLegend.horizontalAlignment = .center
        chartLegend.textColor = #colorLiteral(red: 0.3058823529, green: 0.3098039216, blue: 0.3058823529, alpha: 1)
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 10)
        yAxis.setLabelCount(6, force: true)
        yAxis.labelTextColor = #colorLiteral(red: 0.3058823529, green: 0.3098039216, blue: 0.3058823529, alpha: 1)
        yAxis.axisLineColor = .black
        yAxis.gridColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 10)
        xAxis.labelTextColor = #colorLiteral(red: 0.3058823529, green: 0.3098039216, blue: 0.3058823529, alpha: 1)
        xAxis.axisLineColor = .black
        xAxis.gridColor = #colorLiteral(red: 0.8773933649, green: 0.8721780181, blue: 0.8814024925, alpha: 1)
        
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
        guard let view = self.loadViewFromNib(nibName: "lineChartComponent")
            else { return }
        marker.isHidden = true
        lineChartView.delegate = self
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.tag = 100
        self.addSubview(view)
        self.configureChart()
    }
    
    private func configureChart(){
        viewComponent.addSubview(lineChartView)
        lineChartView.frame.size.width = 343
        lineChartView.frame.size.height = viewComponent.frame.height
        lineChartView.topAnchor.constraint(equalTo: viewComponent.topAnchor).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: viewComponent.leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: viewComponent.trailingAnchor).isActive = true
        lineChartView.bottomAnchor.constraint(equalTo: viewComponent.bottomAnchor).isActive = true
        lineChartView.translatesAutoresizingMaskIntoConstraints = true
        
//        self.viewComponent.layoutIfNeeded()
    }
    
    func setDataSetsPressures(systolicDataSet: [ChartDataEntry], diastolicDataSet: [ChartDataEntry], pulseDataSet: [ChartDataEntry]) {
        let dataSets: [LineChartDataSet] = [
            LineChartDataSet(entries: systolicDataSet, label: "Presión Sistólica"),
            LineChartDataSet(entries: diastolicDataSet, label: "Presión Diastólica"),
            LineChartDataSet(entries: pulseDataSet, label: "Pulso")
        ]
        let data = LineChartData(dataSets: dataSets)
        data.setDrawValues(false)
        
        for (index, set) in dataSets.enumerated() {
            set.drawCirclesEnabled = true
            set.circleRadius = CGFloat(2.1)
            set.circleColors = [colors[index]]
            set.mode = .cubicBezier
            set.lineWidth = 2
            set.setColor(colors[index])
            set.drawHorizontalHighlightIndicatorEnabled = false
            set.highlightColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            
        }        
        
        lineChartView.data = data
    }
    
    func setDataSetsMessures(weightDataSet: [ChartDataEntry], abdominalLengthDataSet: [ChartDataEntry]){
        let dataSets: [LineChartDataSet] = [
            LineChartDataSet(entries: weightDataSet, label: "Peso"),
            LineChartDataSet(entries: abdominalLengthDataSet, label: "Circumferencia Abdominal")
        ]
        let data = LineChartData(dataSets: dataSets)
        data.setDrawValues(false)
        
        for (index, set) in dataSets.enumerated() {
            set.drawCirclesEnabled = true
            set.circleRadius = CGFloat(2.1)
            set.circleColors = [colors[index]]
            set.mode = .cubicBezier
            set.lineWidth = 2
            set.setColor(colors[index])
            set.drawHorizontalHighlightIndicatorEnabled = false
            set.highlightColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            
        }
        lineChartView.data = data
        lineChartView.notifyDataSetChanged()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
    let marker: BalloonMarker =
        BalloonMarker(color: #colorLiteral(red: 0.9333333333, green: 0.937254902, blue: 0.9607843137, alpha: 1),
                      font: UIFont(name: "Helvetica", size: 12)!,
                      textColor: .black,
                      insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0))
        marker.minimumSize = CGSize(width: 45.0, height: 35.0)
        chartView.marker = marker
    }
    // function to remove subview and the add it again
    func clearChart(){
        if let viewToRemove = self.viewComponent.viewWithTag(100) {
            viewToRemove.removeFromSuperview()
            lineChartView.data = nil
            configureView()
        }
    }

}

