//
//  CryptoDetailContainerTest.swift
//  CryptoRadarTests
//
//  Created by ale farina on 04/11/22.
//

import XCTest
import Combine
@testable import CryptoRadar


class CryptoDetailContainerTest: XCTestCase {
    var container: MVIContainer<CryptoDetailIntent,CryptoDetailModel>!
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        let model = CryptoDetailModel()
        self.container = MVIContainer(
            intent: CryptoDetailIntent(model: model, service: RequestManager(apiManager: MockAPIManager()), id: "id"),
            model: model,
            modelChangePublisher: model.objectWillChange)
        
        self.cancellables = []
        
    }

    override func tearDownWithError() throws {
        container = nil
        self.cancellables = []
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFecthCoinDetailSuccesfull() async throws {
        let expectation = XCTestExpectation(description: "fetch coins")
        
        container.model.$state.dropFirst(2)
            .sink { state in
                
                XCTAssertNotNil(self.container.model.detail)
                XCTAssertNotNil(self.container.model.data)
                
                expectation.fulfill()
            }.store(in: &cancellables)

        await container.intent.fetchDetail()
        
        wait(for: [expectation], timeout: 5)
        
    }
}
