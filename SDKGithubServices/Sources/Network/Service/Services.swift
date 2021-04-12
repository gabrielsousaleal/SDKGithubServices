//
//  Services.swift
//  SDKGithubServices
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation

public class Services: ServicesProtocol {

    // MARK: - Constants

    private let kCodeLanguageKey = "q"
    private let kPageKey = "page"
    private let kCodeLanguageValue = "language:%@"
    private let kSortValue = "stars"
    private let kSortKey = "sort"

    // MARK: - Private Properties

    private let operations = NetworkOperations()

    // MARK: - Public Properties

    public static let shared = Services()

    // MARK: - Public Methods

    public func getUser(username: String, success: @escaping (Data) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = URL(string: String(format: operations.user, username)) else {
            return
        }
        request(url: url,
                success: { data in
                    success(data)
                },
                failure: { error in
                    failure(error)
                })
    }

    public func getRepositories(language: String, page: Int, success: @escaping (Data) -> Void, failure: @escaping(Error) -> Void) {
        guard let url = getRepositoriesListUrl(language: language, page: page) else {
            return
        }
        request(url: url,
                success: { data in
                    success(data)
                },
                failure: { error in
                    failure(error)
                })
    }

    public func request(url: URL, success: @escaping(Data) -> Void, failure: @escaping(Error) -> Void) {
        print("aqui", url)
    var request = URLRequest(url: url,
                                cachePolicy: .useProtocolCachePolicy,
                                timeoutInterval: 100.0)
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

    private func getUserParams() -> Params {
        var params = Params()
        params.method = .get
        return params
    }

    private func getRepositoriesListParams(language: String, page: Int) -> Params {
        var params = Params()
        params.method = .get
        params.query = [kPageKey: page,
                        kSortKey: kSortValue,
                        kCodeLanguageKey: String(format: kCodeLanguageValue, language)]
        return params
    }

    private func getRepositoriesListUrl(language: String, page: Int) -> URL? {
        let params = getRepositoriesListParams(language: language, page: page)
        var url = operations.repositoriesList
        url?.query = params.queryString
        return url?.url
    }
}
