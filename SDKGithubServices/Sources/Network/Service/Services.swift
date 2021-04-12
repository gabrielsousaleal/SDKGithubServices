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
    private let kSortKey = "sort"
    private let tokenKey = "Authorization"
    private var token: String {
        let bundle = Bundle(for: Services.self)
        let base64 = bundle.object(forInfoDictionaryKey: "Api_token") as? String ?? .empty
        let encoded = Data(base64Encoded: base64) ?? Data()
        return String(data: encoded, encoding: .utf8) ?? .empty
    }

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

    public func getRepositories(language: String, page: Int, sortBy: String, success: @escaping (Data) -> Void, failure: @escaping(Error) -> Void) {
        guard let url = getRepositoriesListUrl(language: language, page: page, sortBy: sortBy) else {
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
        var request = URLRequest(url: url,
                                cachePolicy: .useProtocolCachePolicy,
                                timeoutInterval: 100.0)
        request.httpMethod = HTTPMethod.get.rawValue
        request.addValue(token, forHTTPHeaderField: tokenKey)
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

    private func getRepositoriesListParams(language: String, page: Int, sortBy: String) -> Params {
        var params = Params()
        params.method = .get
        params.query = [kPageKey: page,
                        kSortKey: sortBy,
                        kCodeLanguageKey: String(format: kCodeLanguageValue, language)]
        return params
    }

    private func getRepositoriesListUrl(language: String, page: Int, sortBy: String) -> URL? {
        let params = getRepositoriesListParams(language: language, page: page, sortBy: sortBy)
        var url = operations.repositoriesList
        url?.queryItems = []
        params.query.forEach { item in
            url?.queryItems?.append(URLQueryItem(name: item.key, value: "\(item.value)"))
        }
        return url?.url
    }
}
