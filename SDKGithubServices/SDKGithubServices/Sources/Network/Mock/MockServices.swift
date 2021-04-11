//
//  MockServices.swift
//  SDKGithubServices
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation

public class MockServices: ServicesProtocol {

    // MARK: - Private Properties

    private let jsonExtension = "json"

    // MARK: - Public Properties

    public static let shared = MockServices()

    // MARK: - Public Methods

    public func getRepositories(language: String, page: Int, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        let path = "list"

        if let url = Bundle(for: MockServices.self).url(forResource: path, withExtension: jsonExtension) {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                success(data)
            } catch {
                failure(error)
            }
        }
    }
}
