//
//  ReposInteractorTests.swift
//  GitRepoTests
//
//  Created by Thyago on 08/12/20.
//  Copyright © 2020 tcasablancas. All rights reserved.
//

import XCTest
@testable import GitRepo

class ReposInteractorTests: XCTestCase {

    func testInteractorDidGetData() {
        // Given
        let repository = Repository(name: "Alamofire", url: nil, description: nil, stargazers_count: 1000, forks_count: 1000, pulls_url: nil)
        let githubData = GithubData(total_count: 1, incomplete_results: false, items: [repository])
        
        let spy = ReposInteractorOutputSpy()
        let stub = RepoWorkerStub(response: .success(model: githubData))
        let sut = ReposInteractor(output: spy, worker: stub)
        
        // When
        sut.getData()
        
        // Then
        XCTAssertEqual(spy.repositoriesCalled, [[repository]])
        XCTAssertEqual(spy.messages, [.load, .success])
        
    }
    
    func testInteractorDidGetTimeoutError() {
        // Given
        let spy = ReposInteractorOutputSpy()
        let stub = RepoWorkerStub(response: .timeOut(description: ServerError(msgError: "timeout", statusCode: 1001)))
        let sut = ReposInteractor(output: spy, worker: stub)
        
        // When
        sut.getData()
        
        // Then
        XCTAssertEqual(spy.errorsCalled, ["Timeout"])
        XCTAssertEqual(spy.messages, [.load, .error])
        
    }
    
    func testInteractorDidGetTimeoutErrorAndOffline() {
        // Given
        let spy = ReposInteractorOutputSpy()
        let stub = RepoWorkerStub(response: .timeOut(description: ServerError(msgError: "timeout", statusCode: 1001)))
        let sut = ReposInteractor(output: spy, worker: stub)
        
        // When
        sut.getData()
        
        // Then
        XCTAssertEqual(spy.errorsCalled, ["Timeout"])
        XCTAssertEqual(spy.messages, [.load, .error])
        
        stub.response = .noConnection(description: ServerError(msgError: "offline", statusCode: 999))
        
        sut.getData()
        
        XCTAssertEqual(spy.errorsCalled, ["Timeout", "Offline"])
        XCTAssertEqual(spy.messages, [.load, .error, .load, .error])
        
    }
}

private class ReposInteractorOutputSpy: ReposInteractorOutput {
    
    enum Messages {
        case load
        case success
        case error
    }
    
    private(set) var messages = [Messages]()
    
    private(set) var didStartLoadingCalled = false
    func didStartLoading() {
        messages.append(.load)
    }
    
    private(set) var repositoriesCalled = [[Repository]]()
    func didGetData(_ repositories: [Repository]) {
        repositoriesCalled.append(repositories)
        messages.append(.success)
    }
    
    private(set) var errorsCalled = [String]()
    func didGetError(_ error: String) {
        errorsCalled.append(error)
        messages.append(.error)
    }
}

private class RepoWorkerStub: RepoWorker {

    var response: ResponseGithubRepo<GithubData>
    
    init(response: ResponseGithubRepo<GithubData>) {
        self.response = response
    }
    
    func loadRepoList(page: Int, completion: @escaping (ResponseGithubRepo<GithubData>) -> Void) {
        completion(response)
    }
}
