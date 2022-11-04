//
//  CryptoListContainerTest.swift
//  CryptoRadarTests
//
//  Created by ale farina on 04/11/22.
//

import XCTest
import Combine
@testable import CryptoRadar

class CryptoListContainerTest: XCTestCase {
    var container: MVIContainer<CryptoListIntent,CryptoListModel>!
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        let model = CryptoListModel()
        self.container = MVIContainer(
            intent: CryptoListIntent(model: model, service: RequestManager(apiManager: MockAPIManager())),
            model: model,
            modelChangePublisher: model.objectWillChange)
        
        self.cancellables = []
        
    }

    override func tearDownWithError() throws {
        self.container = nil
        self.cancellables = []
    }
    
    func testFecthCoinsSuccesfull() async throws {
        let expectation = XCTestExpectation(description: "fetch coins")
        
        container.model
            .$state
            .dropFirst(2)
            .sink { coin in
                XCTAssertEqual(self.container.model.coins.count, 9)
                expectation.fulfill()
            }.store(in: &cancellables)
        
        await container.intent.fetchCrypto()

        wait(for: [expectation], timeout: 5)
        
    }
}


