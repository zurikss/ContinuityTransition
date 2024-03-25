//
//  HomeView.swift
//  ContinuityTransition
//
//  Created by Victor on 23/03/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var show: Bool = false
    @State private var appear: Bool = true
    @State private var selectedExpandIndex: Int? = nil
    var namespace: Namespace.ID
    
    let section: [ExpandSection] = [
        ExpandSection(title: "Book", description: "Book flights, hotels, and activities for your next adventure.", imageName: "airplane", backgroundColor: .orange),
        
        ExpandSection(title: "Explore", description: "Discover new destinations and plan your itinerary.", imageName: "map.fill", backgroundColor: .pink),
        
        ExpandSection(title: "Stay", description: "Find the perfect accommodation for a comfortable stay.", imageName: "house.fill", backgroundColor: .teal),
    ]

    
    let expand: ExpandSection
    
    var body: some View {
        
         ZStack(alignment: .bottomTrailing) {
             lowFidelity
             
             // This controls navigation to other views. Currently there are 4 main views, you can add more if you want.
             if viewModel.selectedExpandIndex != nil {
                     if let index = viewModel.selectedExpandIndex {
                         switch index {
                         case 0:
                             FirstExpandedView(namespace: namespace)
                         case 1: 
                             SecondExpandedView(namespace: namespace)
                         case 2:
                             ThirdExpandedView(namespace: namespace)
                         default:
                             HomeView(namespace: namespace, expand: ExpandSection(title: "", description: "", imageName: "", backgroundColor: .clear))
                         }
                     }
                 } else {
                     ZStack(content: {
                         combinedViews
                             .padding(20)
                             //.offset(y: viewModel.showItems ? 0 : -80)
                     })
                     .transition(.scale(scale: 1))
                 }
         }
    }
}


struct HomeView_Preview: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        HomeView(namespace: namespace, expand: ExpandSection(title: "Send", description: "Send tokens or collectibles to any address or ENS username.", imageName: "paperplane.fill", backgroundColor: .blue))
            .environmentObject(HomeViewModel())
    }
}

struct ExpandView: View {
    let expand: ExpandSection

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: expand.imageName)
                .font(.body)
                .fontWeight(.semibold)
                .padding(8)
                .foregroundStyle(.gray0)
                .background(expand.backgroundColor.gradient)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(expand.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray0)

                Text(expand.description)
                    .font(.callout)
                    .foregroundStyle(.gray300)
            }
        }
        .fontDesign(.rounded)
        .padding(16)
        .frame(width: 336, alignment: .leading)
        .background(.gray800.opacity(0.6))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.gray700, lineWidth: 0.7)
        }
    }
}


extension HomeView {
    var plusButton: some View {
        Button {
            HapticManager.instance.impact(style: .light)
            
            withAnimation(.spring(response: 0.25, dampingFraction: 0.85, blendDuration: 1)) {
                viewModel.showItems = true
            }
            
        } label: {
            Image(systemName: "plus")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.gray0)
                .padding(16)
        }

    }
    
    var combinedViews: some View {
        ZStack {
            if !viewModel.showItems {
                plusButton
            }
            else {
                VStack(alignment: .leading, spacing: 8) {
                    if !viewModel.showNextView {
                        ZStack {
                            VStack(alignment: .leading, spacing: 8, content: {
                                ForEach(section.indices, id: \.self) { index in
                                    Button {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
                                            viewModel.selectedExpandIndex = index
                                            viewModel.moveItems = true
                                        }
                                        
                                    } label: {
                                        ExpandView(expand: section[index])
                                    }
                                    .buttonStyle(BouncyButton())
                                }
                            })
                        }
                    }
                }
                .offset(y: viewModel.moveItems ? -150 : 0)
            }
        }
        .padding(viewModel.showItems ? 8 : 0)
        .background(
            RoundedRectangle(cornerRadius: viewModel.showItems ? 24 : 32, style: .continuous)
                .fill(.gray900)
                .matchedGeometryEffect(id: "background", in: namespace)
        )
        .mask({
            RoundedRectangle(cornerRadius: viewModel.showItems ? 24 : 32, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        })
    }
    
    var lowFidelity: some View {
        ZStack(alignment: .bottom, content: {
            ScrollView {
                VStack(alignment: .center, spacing: 24) {
                    HStack(alignment: .center, spacing: 24, content: {
                        ForEach(0..<2) { index in
                            Rectangle()
                                .foregroundStyle(.gray100)
                                .frame(width: 70, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                        }
                    })
                    
                    HStack(alignment: .top, spacing: 8) {
                        VStack(alignment: .center, spacing: 16, content: {
                            ForEach(0..<7) { index in
                                Rectangle()
                                    .foregroundStyle(.gray100)
                                    .frame(width: 175, height: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            }
                        })
                        
                        VStack(alignment: .center, spacing: 16, content: {
                            ForEach(0..<10) { index in
                                Rectangle()
                                    .foregroundStyle(.gray100)
                                    .frame(width: 175, height: 156)
                                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            }
                        })

                    }
                }
                .padding(.top, 24)
            }
            .scrollIndicators(.hidden)
        })
        .padding(.horizontal, 20)
        .background(.gray0)
        .onTapGesture {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.85, blendDuration: 1)) {
                viewModel.showItems = false
            }
        }

    }
}


