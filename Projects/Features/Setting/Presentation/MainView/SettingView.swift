//
//  SettingView.swift
//  SettingData
//
//  Created by Yejin Hong on 12/9/25.
//

import SwiftUI
import DesignSystem

public struct SettingView: View {
    @State private var navigationPath: SettingDestinations = .init()
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                VStack(alignment: .center) {
                    MainNavigationBar(theme: .dark, onMenuTab: {}, onAccountTab: {})
                        .frame(height: 30)
                    
                    Text("설정")
                        .font(DSFont.bold(30))
                        .padding(.top)
                    
                    SettingSubView(title: "고객센터", content: {
                        VStack {
                            ContentCell(image: DesignSystemAsset.star.image, title: "별점 남기러 가기")
                        }
                    })
                    .frame(height: 120)
                    .padding()
                    
                    SettingSubView(title: "기타", content: {
                        VStack {
                            ContentCell(image: DesignSystemAsset.license.image, title: "라이센스")
                                .onTapGesture {
                                    navigationPath.append(.license)
                                }
                            ContentCell(image: DesignSystemAsset.help.image, title: "라이브러리 목록")
                                .onTapGesture {
                                    navigationPath.append(.libraryInfo)
                                }
                            ContentCell(image: DesignSystemAsset.info.image, title: "앱 버전", subTitle: "1.0.0")
                        }
                    })
                    .frame(height: 210)
                    .padding()
                    
                    Spacer()
                }
            }
            .navigationDestination(for: SettingViews.self) { views in
                switch views {
                case .libraryInfo:
                    LibraryInfoView()
                case .license:
                    LicenseView()
                }
            }
            .background(
                Image(uiImage: DesignSystemAsset.grayBackground.image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
        }
        .navigationBarHidden(true)
    }
}

struct SettingSubView<Content: View>: View {
    var title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(DSFont.bold(18))
                .foregroundStyle(DesignSystemAsset.menuButton.swiftUIColor)
                .padding(.vertical)
                .padding(.leading, 6)
            
            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .foregroundStyle(.white)
                    .shadow(radius: 2)
                
                content
            }
        }
    }
}

struct ContentCell: View {
    var image: UIImage
    var title: String
    var subTitle: String?
    
    var body: some View {
        HStack {
            Image(uiImage: image)
                .resizable()
                .frame(width: 24, height: 24)
            Text(title)
                .font(DSFont.medium(16))
                .foregroundStyle(DesignSystemAsset.gray.swiftUIColor)
            Spacer()
            
            Text(subTitle ?? "")
                .font(DSFont.medium(14))
                .foregroundStyle(DesignSystemAsset.disableButton.swiftUIColor)
            
            Image(uiImage: DesignSystemAsset.chevronRight.image)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview {
    SettingView()
}
