//
//  SecondExpandedView.swift
//  ContinuityTransition
//
//  Created by Victor on 24/03/2024.
//

import SwiftUI

struct SecondExpandedView: View {
    
    var namespace: Namespace.ID
    @State private var textField: String = ""
    @State private var appear: Bool = false
    @EnvironmentObject var viewModel: HomeViewModel
    
    let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
    
    var body: some View {
        ZStack {
            Color.gray900.ignoresSafeArea()
            VStack(alignment: .center, spacing: 16) {
                HStack {
                    Text("Explore")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.gray0)
                    Spacer()
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
                            viewModel.showItems = true
                            HapticManager.instance.impact(style: .soft)
                            viewModel.selectedExpandIndex = nil
                        }
                        withAnimation(.spring(response: 0.32, dampingFraction: 0.9)) {
                            viewModel.moveItems = false
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .renderingMode(.template)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray100)
                            .padding(12)
                            .background(.gray800)
                            .cornerRadius(32)
                })
                }
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0..<12) { index in
                            Rectangle()
                                .foregroundStyle(.gray800.opacity(0.6))
                                .frame(height: 150, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        }
                    }
                }
                .scrollDisabled(false)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            .padding(.top, 80)
            .scaleEffect(appear ? 1 : 0.5, anchor: .bottom)
            .opacity(appear ? 1 : 0)
            .transition(.scale(scale: 1)) // this transition is kept to remove the default opacity fade when using a matchedGeometryEffect.

        }
        .fontDesign(.rounded)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.gray900)
                .matchedGeometryEffect(id: "background", in: namespace)
        )
        .mask({
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
            
        })
        .transition(.scale(scale: 1))
        .ignoresSafeArea(.all)
        .onAppear(perform: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.85, blendDuration: 1)) {
                appear = true
            }
        })
    }
}

struct SecondExpandedView_Preview: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        SecondExpandedView(namespace: namespace)
            .environmentObject(HomeViewModel())
    }
}
