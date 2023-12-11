//
//  ContentView.swift
//  AustraliaCityList
//
//  Created by raju.bannishetti on 11/12/23.
//

import SwiftUI

struct StateListView: View {
    @StateObject var viewModel = CityListViewModel()
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @StateObject private var expansionHandler = ExpansionHandler<String>()
    
    var body: some View {
        NavigationView {
            //TODO: Here we are checking network connection is available or not
            if !networkMonitor.isConnected {
                NetworkErrorView(networkMonitor: networkMonitor)
            } else {
                VStack {
                    List {
                        ForEach(viewModel.sectionHeaders, id: \.self) { key in
                            DisclosureGroup(
                                //TODO: This will help us to only have one group expanded at a time, and automatically hiding the last one, when expanding a new one.
                                isExpanded: self.expansionHandler.isExpanded(viewModel.sectionHeader(key)),
                                content: {
                                    ForEach(viewModel.sectionContent(key), id: \.city) { city in
                                        CityRowView(city: city)
                                    }
                                },
                                label: {
                                    HStack {
                                        Text(viewModel.sectionHeader(key))
                                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                            .font(.headline)
                                        
                                    }.foregroundColor(Color.accentColor)
                                }
                            )
                        }
                    }
                }.navigationTitle("State List")
            }
        }
    }
}

struct CityRowView: View {
    
    let city: City
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                customDataBinding(data: city.city, title: "\(LabelNames.city)", titleFontStyle: FontHelper.header, dataFontstyle: FontHelper.header)
            }
            HStack {
                customDataBinding(data: city.lat, title: "\(LabelNames.latitude)", titleFontStyle: FontHelper.subheader, dataFontstyle: FontHelper.body1)
            }
            HStack {
                customDataBinding(data: city.lng, title: "\(LabelNames.longitude)", titleFontStyle: FontHelper.subheader, dataFontstyle: FontHelper.body1)
            }
            HStack {
                customDataBinding(data: city.population, title: "\(LabelNames.population)", titleFontStyle: FontHelper.subheader, dataFontstyle: FontHelper.body1)
            }
        }.padding(.leading)
         .cornerRadius(10)
         .listStyle(SidebarListStyle())
    }
}

struct customDataBinding: View {
    @Environment(\.colorScheme) private var colorScheme
    let data: String
    let title: String
    let titleFontStyle: String
    let dataFontstyle: String
    var body: some View {
        HStack {
            Text(title)
                .font(.custom(titleFontStyle, size: CGFloat(ListFontSize.listTitleSize)))
                .padding(.top, CGFloat(ListFontSize.listTitleTopPadding))
                .accessibilityLabel(title)
                .foregroundColor(Color.mint)
                
            Spacer()
            Text(data)
                .font(.custom(dataFontstyle, size: CGFloat(ListFontSize.listTitleSize)))
                .padding(.top, CGFloat(ListFontSize.listTitleTopPadding))
                .accessibilityLabel(data)
                .foregroundColor(colorScheme == .light ? .black : .white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StateListView(viewModel: CityListViewModel(forPreview: true))
    }
}

