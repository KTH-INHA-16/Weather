//
//  WeatherMainView.swift
//  Weather
//
//  Created by 김태훈 on 2022/07/04.
//

import SwiftUI

struct WeatherMainView: View {
    @StateObject var viewModel = WeatherMainViewModel()
    
    var body: some View {
        Text("")
    }
}

struct WeatherMainView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherMainView()
    }
}
