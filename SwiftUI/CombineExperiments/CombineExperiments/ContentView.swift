//
//  ContentView.swift
//  CombineExperiments
//
//  Created by Ivan Pryhara on 23.03.23.
//

import SwiftUI
import Combine

class SubViewModel: ObservableObject {
    
    @Published var count: Int  = 0
    
    var timer: AnyCancellable?
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var textTextField = ""
    @Published var textIsValid: Bool = false
    @Published var showButton: Bool = false
    init() {
        setupTimer()
        addTextFieldSub()
        addButtonSub()
    }
    
    func setupTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1

            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSub() {
        $textTextField
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text -> Bool in
                if text.count > 3 {
                    return true
                } else {
                    return false
                }
            }
            .sink(receiveValue: { [weak self] isValid in
                
                guard let self = self else { return }
                        
                self.textIsValid = isValid
                        
            })
            .store(in: &cancellables)
    }
    
    func addButtonSub() {
         $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}


struct ContentView: View {
    
    @StateObject var vm = SubViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            if #available(iOS 16.0, *) {
                TextField("Type something", text: $vm.textTextField, axis: .vertical)
                    .padding(.leading)
                    .lineLimit(1...10)
                    .frame(height: 55)
                    .font(.headline)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .overlay (
                        ZStack {
                            Image(systemName: vm.textIsValid ? "checkmark" : "xmark")
                                .foregroundColor(vm.textIsValid ? .green : .red)
                                .opacity(vm.textTextField.count < 1 ? 0 : 1)
                        }
                            .font(.headline)
                            .padding(.trailing, 30),
                        alignment: .trailing
                    )
                Button(action: {}) {
                    Text("Submit".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .opacity(vm.showButton ? 1 : 0.5)
                }
                .disabled(!vm.showButton)
            } else {/*fallback to previous versions*/}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
