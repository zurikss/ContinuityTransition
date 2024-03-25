//
//  FirstExpandedView.swift
//  ContinuityTransition
//
//  Created by Victor on 23/03/2024.
//

import SwiftUI

struct FirstExpandedView: View {
    
    var namespace: Namespace.ID
    @State private var textField: String = ""
    @State private var appear: Bool = false
    @EnvironmentObject var viewModel: HomeViewModel     
    
    var body: some View {
        ZStack {
            Color.gray900.ignoresSafeArea()
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Book")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.gray0)
                        
                        Spacer()
                        Button(action: {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) {
                                viewModel.showItems = true
                                HapticManager.instance.impact(style: .light)
                                viewModel.selectedExpandIndex = nil
                            }
                            withAnimation(.spring(response: 0.28, dampingFraction: 0.9)) {
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
                   
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(0..<20) { index in
                                Rectangle()
                                    .foregroundStyle(.gray800.opacity(0.6))
                                    .frame(width: .random(in: 200..<350), alignment: .leading)
                                    .frame(height: .random(in: 40..<50), alignment: .leading)
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                .padding(.top, 80)
                
                
                Button {
                    
                } label: {
                    Rectangle()
                        .foregroundStyle(.gray0)
                        .frame(width: 300, height: 56, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous)) 
                        .padding(48)
                }
                .buttonStyle(BouncyButton())
            }
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

struct FirstExpandedView_Preview: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        FirstExpandedView(namespace: namespace)
            .environmentObject(HomeViewModel())
    }
}
