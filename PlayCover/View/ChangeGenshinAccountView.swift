//
//  ChangeGenshinAccountView.swift
//  PlayCover
//
//  Created by José Elias Moreno villegas on 21/07/22.
//
import SwiftUI

struct ChangeGenshinAccountView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var folderName: String = ""
    @State var accountList: [String] = getAccountList()
    @State var restoreAlert: Bool = false
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer()
            Text("storeAccount.selectAcc").font(.largeTitle).lineLimit(1).fixedSize()
            Spacer()
            ForEach(accountList, id: \.self) { account in
                if account != ".DS_Store"{
                    Button(action: {
                        self.folderName = account
                        self.restoreAlert = true
                    }, label: {
                        HStack {
                            Image(systemName: "person.fill")
                            Text(account)
                        }.frame(minWidth: 300, alignment: .center)
                    }).controlSize(.large).buttonStyle(.automatic).font(.title3)
                        .foregroundColor(.accentColor)
                        .frame(width: 300, alignment: .center)
                        .alert("Really Restore Account?", isPresented: $restoreAlert, actions: {
                            Button("Restore Account") {
                                restoreUserData(folderName: account)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            .controlSize(.large).padding()
                            Button("Cancel", role: .cancel) {}
                                .controlSize(.large).padding()
                        }, message: {
                            Text("This will override your currently signed-in account.")
                        })
                }
            }.frame(width: 450)
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("button.Cancel").frame(alignment: .center)
            }).controlSize(.large).padding()
        }
        .frame(minWidth: 300)
    }
}

struct ChangeGenshinAccountView_preview: PreviewProvider {
    static var previews: some View {
        ChangeGenshinAccountView()
    }
}
