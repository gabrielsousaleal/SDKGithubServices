//
//  ServicesProtocol.swift
//  SDKGithubServices
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

struct Params {

    // MARK: - Public Properties

    var method: HTTPMethod = .get
    var header: [String: Any] = [:]
    var body: [String: Any] = [:]
    var query: [String: Any] = [:]

    var queryString: String {
        var queryItemList: [URLQueryItem] = []
        query.forEach { item in
            let valueString = "\(item.value)"
            queryItemList.append(URLQueryItem(name: item.key, value: valueString))
        }
        let query = "\(queryItemList)"
        return query
    }
}

public protocol ServicesProtocol: AnyObject {
    func getRepositories(language: String, page: Int, sortBy: String, success: @escaping(Data) -> Void, failure: @escaping(Error) -> Void)
    func getUser(username: String, success: @escaping(Data) -> Void, failure: @escaping(Error) -> Void)
    func request(url: URL, success: @escaping(Data) -> Void, failure: @escaping(Error) -> Void)
}
