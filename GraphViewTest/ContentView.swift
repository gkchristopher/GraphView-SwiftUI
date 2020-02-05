//
//  ContentView.swift
//  GraphViewTest
//
//  Created by Christopher Moore on 2/5/20.
//  Copyright © 2020 Roving Mobile. All rights reserved.
//

import SwiftUI

extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force) }
    }
}

struct ContentView: View {
    @ObservedObject private var keyboardObserver = KeyboardObserver()

    @State var point0 = ""
    @State var point1 = ""
    @State var point2 = ""
    @State var point3 = ""
    @State var point4 = ""
    @State var point5 = ""
    @State var point6 = ""

    var body: some View {
        NavigationView {
            Form {
                Section {
                    GraphView(values: [cgfloatValue(for: point0),
                                       cgfloatValue(for: point1),
                                       cgfloatValue(for: point2),
                                       cgfloatValue(for: point3),
                                       cgfloatValue(for: point4),
                                       cgfloatValue(for: point5),
                                       cgfloatValue(for: point6)])
                        .frame(height: CGFloat(300.0))
                }
                Section {
                    TextField("Point 0", text: $point0)
                        .keyboardType(.decimalPad)
                    TextField("Point 1", text: $point1)
                        .keyboardType(.decimalPad)
                    TextField("Point 2", text: $point2)
                        .keyboardType(.decimalPad)
                    TextField("Point 3", text: $point3)
                        .keyboardType(.decimalPad)
                    TextField("Point 4", text: $point4)
                        .keyboardType(.decimalPad)
                    TextField("Point 5", text: $point5)
                        .keyboardType(.decimalPad)
                    TextField("Point 6", text: $point6)
                        .keyboardType(.decimalPad)
                }
            }
            .modifier(KeyboardAdapter())
            .animation(.easeInOut(duration: 0.3))
            .navigationBarTitle("Graph View")
        }
        .onTapGesture {
            self.endEditing(true)
        }
    }

    func cgfloatValue(for str: String) -> CGFloat {
        CGFloat(Double(str) ?? 0.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GraphView: View {
    var values: [CGFloat]

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 1
        return formatter
    }()

    var body: some View {
        HStack(alignment: .bottom, spacing: 30) {
            ForEach(values, id: \.self) { value in
                VStack {
                    GeometryReader { geo in
                        ZStack(alignment: .bottom) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
                            if value > CGFloat.zero {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.blue)
                                    .frame(height: geo.size.height * value)
                            }
                        }
                    }
                    Text(self.display(for: value))
                        .font(.caption)
                }
            }
        }
    }

    func display(for value: CGFloat) -> String {
        formatter.string(for: value) ?? ""
    }
}
