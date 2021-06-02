//
//  RecipeCookingDurationView.swift
//  Hand-free-Recipe
//
//  Created by Guyleaf on 2021/6/1.
//

import SwiftUI

struct RecipeCookingDurationView: View {
    var estimatedTime: Int?

    let durationList = ["天", "小時", "分鐘", "秒"]

    func calculatDuration() -> [Int]? {
        guard var duration = estimatedTime else { return nil }

        var tmp = [Int]()
        tmp.append(duration % 60)
        duration /= 60
        tmp.append(duration % 60)
        duration /= 60
        tmp.append(duration % 24)
        duration /= 24
        tmp.append(duration)

        return tmp.reversed()
    }

    var body: some View {
        if let durations = calculatDuration() {
            HStack {
                Spacer()
                Label(
                    title: {
                        ForEach(durations.indices) { index in
                            if (durations[index] != 0) {
                                Text("\(durations[index]) \(durationList[index])")
                            }
                        }
                    },
                    icon: { Image(systemName: "clock") }
                )
                Spacer()
            }

            Line()
                .stroke(style: StrokeStyle(lineWidth: 1))
                .frame(height: 1)
        }
//        if let duration = cookingDuration {
//            HStack {
//                Spacer()
//                Label(
//                    title: {
//                        Text("\(duration)")
//                    },
//                    icon: { Image(systemName: "clock") }
//                )
//                Spacer()
//            }
//            Line()
//                .stroke(style: StrokeStyle(lineWidth: 1))
//            .frame(height: 1)
//        }
    }
}

struct RecipeCookingDurationView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCookingDurationView()
    }
}
