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
    @Published var buttonIsActive: Bool = false
    
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
                    withAnimation(Animation.easeIn(duration: 0.25)) {
                        self.passwordsIdentical = passwordsIdentical
                    }
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
                withAnimation(Animation.easeIn(duration: 0.25)) {
                    self.passwordsIdentical = passwordsIdentical
                }
            }
            .store(in: &cancellables)
    }
    // TODO: make something with the button. It should be
    func addSingupButtonSub() {
        $passwordsIdentical
            .combineLatest($repeatPasswordText, $repeatPasswordText)
            .sink { passwordsIdentical, passwordText, repeatPasswordText in
                if (passwordText.count > 0 && repeatPasswordText.count > 0) && passwordsIdentical {
                    self.buttonIsActive = true
                } else {
                    self.buttonIsActive = false
                }
            }
            .store(in: &cancellables)
    }
    
}

struct TwoTextFieldsView: View {
    
    @ObservedObject var vm = TwoTextFieldViewModel()
    
    var body: some View {
        VStack {
            
            SecureField("Create new password", text: $vm.passwordText)
                .padding(10)
                .lineLimit(1)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            SecureField("Repeat your password", text: $vm.repeatPasswordText)
                .padding(10)
                .lineLimit(1)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.red, style: StrokeStyle(lineWidth: 1))
                        .opacity((vm.passwordText.count > 0 && vm.repeatPasswordText.count > 0) ? (vm.passwordsIdentical ? 0 : 1) : 0)
                )
                .overlay(alignment: .trailing) {
                    Text("Passwords do not match")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.trailing, 10)
                        .opacity((vm.passwordText.count > 0 && vm.repeatPasswordText.count > 0) ? (vm.passwordsIdentical ? 0 : 1) : 0)
                }
            
            Button {print(vm.passwordsIdentical)} label: {
                Text("Sign Up")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.buttonIsActive ? 1 : 0.5)
                    .onAppear{ print(vm.buttonIsActive) }
            }
            .disabled(!vm.buttonIsActive)
        }
        .padding(.horizontal, 20)
    }
}

struct TwoTextFields_Previews: PreviewProvider {
    static var previews: some View {
        TwoTextFieldsView()
    }
}
