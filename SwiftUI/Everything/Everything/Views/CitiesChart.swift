//
//  CitiesChart.swift
//  Everything
//
//  Created by Ivan Pryhara on 19.09.22.
//

import SwiftUI
import Charts

func date(year: Int, month: Int, day: Int = 1, hour: Int) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour)) ?? Date()
}
// MARK: Sales data
struct SalesSummary: Identifiable {
    let weekday: Date
    let sales: Int
    
    var id: Date { weekday }
}

let cupertinoData: [SalesSummary] = [
    // Monday
    .init(weekday: date(year: 2022, month: 9, day: 1, hour: 2), sales: 50),
    // Tuesday
    .init(weekday: date(year: 2022, month: 9, day: 2, hour: 2), sales: 40),
    // Wednesday
    .init(weekday: date(year: 2022, month: 9, day: 3, hour: 2), sales: 45),
    // Thursday
    .init(weekday: date(year: 2022, month: 9, day: 4, hour: 2), sales: 48),
    // Friday
    .init(weekday: date(year: 2022, month: 9, day: 5, hour: 2), sales: 50),
    // Saturday
    .init(weekday: date(year: 2022, month: 9, day: 6, hour: 2), sales: 54),
    // Sunday
    .init(weekday: date(year: 2022, month: 9, day: 7, hour: 2), sales: 99),
]

let sfData: [SalesSummary] = [
    // Monday
    .init(weekday: date(year: 2022, month: 9, day: 1, hour: 2), sales: 88),
    // Tuesday
    .init(weekday: date(year: 2022, month: 9, day: 2, hour: 2), sales: 94),
    // Wednesday
    .init(weekday: date(year: 2022, month: 9, day: 3, hour: 2), sales: 142),
    // Thursday
    .init(weekday: date(year: 2022, month: 9, day: 4, hour: 2), sales: 103),
    // Friday
    .init(weekday: date(year: 2022, month: 9, day: 5, hour: 2), sales: 121),
    // Saturday
    .init(weekday: date(year: 2022, month: 9, day: 6, hour: 2), sales: 98),
    // Sunday
    .init(weekday: date(year: 2022, month: 9, day: 7, hour: 2), sales: 91),
]

enum City {
    case cupertino, sanFrancisco
}

//MARK: Series data

struct Series: Identifiable {
    let city: String
    let sales: [SalesSummary]
    
    var id: String { city }
}

var seriesData: [Series]  = [
    .init(city: "Cupertion", sales: cupertinoData),
    .init(city: "San Francisco", sales: sfData)
]

struct CitiesChart: View {
    @State var city: City = .cupertino
    
    var data: [SalesSummary] {
        switch city {
        case .sanFrancisco:
            return sfData
        case .cupertino:
            return cupertinoData
        }
    }
    
    var body: some View {
        VStack {
            Picker("City", selection: $city.animation(.easeInOut)) {
                Text("Cupertion").tag(City.cupertino)
                Text("San Francisco").tag(City.sanFrancisco)
            }
            .pickerStyle(.segmented)
            .padding(20)
            // MARK: Sales chart
            Chart(data) { element in
                BarMark(x: .value("Day", element.weekday, unit: .day),
                        y: .value("Sales", element.sales))
            }
            .frame(maxHeight: 200)
            
            //MARK: Series chart
            Chart(seriesData) { data in
                ForEach(data.sales) { element in
                    LineMark(x: .value("Day", element.weekday),
                             y: .value("Sales", element.sales))
                        .foregroundStyle(by: .value("City", data.city))
                        .symbol(by: .value("City", data.city))
                }
            }
            .frame(maxHeight: 200)
            Spacer()
        }
        .padding(15)
    }
}

struct CitiesChart_Previews: PreviewProvider {
    static var previews: some View {
        CitiesChart()
    }
}
