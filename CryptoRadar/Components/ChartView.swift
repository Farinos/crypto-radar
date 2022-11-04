//
//  ChartView.swift
//  CryptoRadar
//
//  Created by ale farina on 01/11/22.
//

import SwiftUI

class ChartViewModel: ObservableObject {
    var marketData: [[Double]]
    
    init(marketData: [[Double]] = []) {
        self.marketData = marketData
    }
    
    var marketPrices: [Double] {
        marketData.map { element in
            element[1]
        }
    }
    
    var firstDay: Double? {
        marketData.map { element in
            element[0]
        }.first
    }
    
    var lastDay: Double? {
        marketData.map { element in
            element[0]
        }.last
    }
    
    var maxY: Double {
        marketPrices.max() ?? 0.0
    }
    
    var minY: Double {
        marketPrices.min() ?? 0.0
    }
}

struct ChartView: View {
    var vm: ChartViewModel
    
    private let lineColor: Color = .green
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(Color.darkColor)
                .padding(20)
                .overlay(chartYAxis
                    .padding(
                        .horizontal, 4),
                         alignment: .leading)
            
            chartDateLabels
                .padding(.horizontal, 4)
            
        }.darkNeumorphicStyle()
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(vm.maxY.formattedWithAbbreviations()).font(.system(size: 8)).foregroundColor(.offWhite).fontWeight(.semibold)
            Spacer()
            Text(((vm.maxY + vm.minY) / 2).formattedWithAbbreviations()).font(.system(size: 8)).foregroundColor(.offWhite).fontWeight(.semibold)
            Spacer()
            Text(vm.minY.formattedWithAbbreviations()).font(.system(size: 8)).foregroundColor(.offWhite).fontWeight(.semibold)
        }.padding(.vertical, 10)
    }
    
    private var chartDateLabels: some View {
        HStack {
            Text(vm.firstDay?.getDate() ?? "").font(.system(size: 8)).foregroundColor(.offWhite).fontWeight(.semibold)
            Spacer()
            Text(vm.lastDay?.getDate() ?? "").font(.system(size: 8)).foregroundColor(.offWhite).fontWeight(.semibold)
        }.padding(5)
    }
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in vm.marketData.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(vm.marketData.count) * CGFloat(index + 1)
                    
                    let yAxis = vm.maxY - vm.minY
                    
                    let yPosition = (1 - CGFloat((vm.marketData[index][1] - vm.minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    
                }
            }
            .trim(from: 0, to: 1)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.3), radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 20)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(vm: ChartViewModel(marketData: []))
    }
}
