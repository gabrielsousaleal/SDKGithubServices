//
//  Services.swift
//  SDKGithubServices
//
//  Created by Gabriel Sousa on 10/04/21.
//

import Foundation
import Alamofire

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
        let params = getRepositoriesListParams(language: language, page: page)
        var url = operations.repositoriesList
        url?.query = params.queryString
        let urlString = url?.string ?? .empty
        AF.request(urlString, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }

    // MARK: - Private Methods

    private func getRepositoriesListParams(language: CodeLanguage, page: Int) -> Params {
        var params = Params()
        params.method =  .get
        params.query = [kCodeLanguageKey: language.rawValue, kPageKey: page]
        return params
    }
}
