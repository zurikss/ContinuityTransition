//
//  HomeViewModel.swift
//  ContinuityTransition
//
//  Created by Victor on 23/03/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var moveItems: Bool = false
    @Published var showItems: Bool = false
    @Published var showNextView: Bool = false
    @Published var selectedExpandIndex: Int? = nil
}
