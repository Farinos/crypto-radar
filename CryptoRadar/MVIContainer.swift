//
//  MVIContainer.swift
//  CryptoRadar
//
//  Created by ale farina on 02/11/22.
//

import Foundation
import Combine

final class MVIContainer<Intent, Model>: ObservableObject {

    let intent: Intent
    let model: Model

    private var cancellable: Set<AnyCancellable> = []

    init(intent: Intent, model: Model, modelChangePublisher: ObjectWillChangePublisher) {
        self.intent = intent
        self.model = model

        // 3
        modelChangePublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellable)
    }
}
