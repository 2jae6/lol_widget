//
//  MainView.swift
//  LoLWidget
//
//  Created by Jay on 2022/01/29.
//

import SwiftUI

struct MainView: View {
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            SearchBar(placeHolder: "소환사 이름을 입력하세요.", text: $viewModel.text)
                .padding(.top)
                .padding(.horizontal, 8)
                .onSubmit {
                    viewModel.searchSummoner()
                }
            Spacer()

            if viewModel.isLoading {
                ProgressView()
            } else if let league = viewModel.league {
                VStack {
                    Text(league.summonerName)
                        .font(.title)
                        .fontWeight(.heavy)

                    if let tier = league.tier {
                        Image("\(tier.tier.rawValue)_emblem")
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                            .frame(maxWidth: 200, maxHeight: 200)
                            .padding(.bottom, 30)
                    }

                    VStack(alignment: .leading) {
                        if let tier = league.tier {
                            LabelAndText(label: "랭크", innerBlock: { () -> Text in
                                if let num = tier.rank {
                                    return Text("\(tier.tier.rawValue) \(num) \(league.points)점")
                                } else {
                                    return Text("\(tier.tier.rawValue) \(league.points)점")
                                }
                            })
                        }
                        LabelAndText(
                            label: "승률",
                            innerView: Text("\(league.wins)승 \(league.losses)패 \(String(format: "%.2f", league.winRate * 100))%")
                        )
                    }
                }
            }

            Spacer()
        }
    }

    @ObservedObject private var viewModel: MainViewModel
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
