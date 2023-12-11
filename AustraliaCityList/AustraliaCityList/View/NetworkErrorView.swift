//
//  NetworkErrorView.swift
//  AustraliaCityList
//
//  Created by raju.bannishetti on 11/12/23.
//

import Foundation
import SwiftUI

struct NetworkErrorView: View {
    var networkMonitor: NetworkMonitor
    @State private var showAlertSheet = false
    
    var body: some View {
        VStack {
            Image(systemName: networkMonitor.isConnected ? WifiConstants.signal : WifiConstants.noSignal)
                .font(.custom(FontHelper.header, size: CGFloat(WifiConstants.headerSize)))
                .padding(.bottom, CGFloat(WifiConstants.headerBottomPadding))
            Button(WifiConstants.buttonName){
                self.showAlertSheet = true
            }.font(.custom(FontHelper.header, size: CGFloat(WifiConstants.buttonSize)))
                .foregroundColor(Color.black)
                .accessibilityHint(WifiConstants.wifiHint)
                .accessibilityLabel(WifiConstants.wifiLabelText)
            
        }.alert(isPresented: $showAlertSheet, content: {
            if networkMonitor.isConnected {
                return Alert(title: Text(WifiConstants.alertTitle), message: Text(WifiConstants.alertMessage), dismissButton: .default(Text(WifiConstants.alertOk)))
            }
            return Alert(title: Text(WifiConstants.errorTitleText), message: Text(WifiConstants.errorMessageText), dismissButton: .default(Text(WifiConstants.alertCancel)))
                
        })
        
            
    }
}
