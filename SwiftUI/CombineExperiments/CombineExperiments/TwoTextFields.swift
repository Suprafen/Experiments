//
//  TwoTextFields.swift
//  CombineExperiments
//
//  Created by Ivan Pryhara on 23.03.23.
//

import SwiftUI
import Combine

class TwoTextFieldViewModel: ObservableObject {
    
    @Published var passwordText: String = ""
    @Published var repeatPasswordText: String = ""
    
    @Published var passwordsIdentical: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addPasswordTextSub()
        addRepeatPasswordTextSub()
        addSingupButtonSub()
    }
    
    
    func addPasswordTextSub() {
        $passwordText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { [weak self] text -> Bool in
                guard let self = self else { return false }
                
                return text == self.repeatPasswordText ? true : false
            }
            .sink { [weak self] passwordsIdentical in
                guard let self else { return }
                
                if !self.repeatPasswordText.isEmpty {
                    self.passwordsIdentical = passwordsIdentical
                }
            }
            .store(in: &cancellables)
    }
    
    func addRepeatPasswordTextSub() {
        $repeatPasswordText
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { [weak self] text -> Bool in
                
                guard let self = self else { return false }
                
                return text == self.passwordText ? true : false
            }
            .sink { [weak self] passwordsIdentical in
                guard let self else { return }
                
                self.passwordsIdentical = passwordsIdentical
            }
            .store(in: &cancellables)
    }
    // TODO: make something with the button. It should be
    func addSingupButtonSub() {
        $passwordsIdentical
            .combineLatest($repeatPasswordText, $repeatPasswordText)
            .sink { passwordsIdentical, passwordText, repeatPasswordText in
                if passwordText.count > 0 && repeatPasswordText.count > 0 {
                    self.passwordsIdentical = passwordsIdentical
                } else {
                    self.passwordsIdentical = false
                }
            }
            .store(in: &cancellables)
    }
    
}

struct TwoTextFieldsView: View {
    
    @ObservedObject var vm = TwoTextFieldViewModel()
    
    var body: some View {
        VStack {
            TextField("Create new password", text: $vm.passwordText, axis: .horizontal)
                .padding(10)
                .lineLimit(1)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            TextField("Repeat your password", text: $vm.repeatPasswordText, axis: .horizontal)
                .padding(10)
                .lineLimit(1)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Button {print(vm.passwordsIdentical)} label: {
                Text("Sign Up")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.passwordsIdentical ? 1 : 0.5)
                    .onAppear{ print(vm.passwordsIdentical) }
            }
            .disabled(!vm.passwordsIdentical)
        }
        .padding(.horizontal, 20)
    }
}

struct TwoTextFields_Previews: PreviewProvider {
    static var previews: some View {
        TwoTextFieldsView()
    }
}
