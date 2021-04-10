//
//  Services.swift
//  SDKGithubServices
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation

public class Services: ServicesProtocol {

    // MARK: - Constants

    private let kCodeLanguageKey = "language"
    private let kPageKey = "page"

    // MARK: - Private Properties

    private let operations = NetworkOperations()

    // MARK: - Public Properties

    public static let shared = Services()

    // MARK: - Public Methods

    public func getRepositories(language: CodeLanguage, page: Int, success: @escaping (Data) -> Void, failure: @escaping(Error) -> Void) {
        guard let url = getRepositoriesListUrl(language: language, page: page) else {
            return
        }
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = HTTPMethod.get.rawValue
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                failure(error)
                return
            }

            if let data = data {
                success(data)
                return
            }
        }
        dataTask.resume()
    }

    // MARK: - Private Methods

    private func getRepositoriesListParams(language: CodeLanguage, page: Int) -> Params {
        var params = Params()
        params.method =  .get
        params.query = [kCodeLanguageKey: language.rawValue, kPageKey: page]
        return params
    }

    private func getRepositoriesListUrl(language: CodeLanguage, page: Int) -> URL? {
        let params = getRepositoriesListParams(language: language, page: page)
        var url = operations.repositoriesList
        url?.query = params.queryString
        return url?.url
    }
}
