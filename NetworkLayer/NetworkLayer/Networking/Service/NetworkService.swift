//
//  NetworkService.swift
//  NetworkLayer
//
//  Created by Виталий Багаутдинов on 05.12.2025.
//

import Foundation


protocol NetworkServiceProtocol: Sendable, AnyObject
{
    func request(config: NetworkConfig, authorized: Bool) async throws
    func request<T: Decodable>(config: NetworkConfig, authorized: Bool) async throws -> T
    func updateAuthorizationToken(_ token: String?)
}

final class NetworkService
{
    private enum NetworkConstants
    {
        static let authorizationHeader = "Authorization"
        static let jsonContentType = "application/json"
        static let contentTypeHeader = "Content-Type"
        static let acceptHeader = "Accept"
    }

    private let decoder = JSONDecoder()
    private let apiConfiguration: ApiConfiguration
    private var authorizationToken: String?

    init(apiConfiguration: ApiConfiguration) {
        self.apiConfiguration = apiConfiguration
    }
}

extension NetworkService: NetworkServiceProtocol {
    func request(config: NetworkConfig, authorized: Bool) async throws {
        let request = try prepareRequest(config: config, authorized: authorized)
        let (_, response) = try await URLSession.shared.data(for: request)
        try validate(response: response)
    }

    func request<T: Decodable>(config: NetworkConfig, authorized: Bool) async throws -> T {
        let request = try prepareRequest(config: config, authorized: authorized)
        let (data, response) = try await URLSession.shared.data(for: request)
        try validate(response: response)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }

    func updateAuthorizationToken(_ token: String?) {
        self.authorizationToken = token
    }
}

private extension NetworkService
{
    func prepareRequest(config: NetworkConfig, authorized: Bool) throws -> URLRequest {
        var request = URLRequest(url: try createRequestURL(config: config))
        request.httpMethod = config.method.rawValue
        request.setValue(NetworkConstants.jsonContentType, forHTTPHeaderField: NetworkConstants.contentTypeHeader)
        request.setValue(NetworkConstants.jsonContentType, forHTTPHeaderField: NetworkConstants.acceptHeader)

        if authorized {
            guard let token = authorizationToken else {
                throw NetworkError.unauthorized
            }
            request.setValue("Bearer \(token)", forHTTPHeaderField: NetworkConstants.authorizationHeader)
        }

        try applyTask(config.task, to: &request)
        return request
    }

    func applyTask(_ task: HTTPTask, to request: inout URLRequest) throws {
        switch task {
        case .request:
            break
        case .requestBody(let data):
            request.httpBody = data
        case .requestUrlParameters(let parameters):
            try URLParameterEncoder.encoding(urlRequest: &request, parameters: parameters)
        }
    }

    func validate(response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw mapError(for: httpResponse.statusCode)
        }
    }

    func mapError(for statusCode: Int) -> Error {
        if let serverError = ServerError.byCode(statusCode) {
            return serverError
        }

        guard let status = HTTPStatusCode(rawValue: statusCode) else {
            return NetworkError.requestFailed
        }

        switch status {
        case .unauthorized:
            return NetworkError.unauthorized
        case .methodNotAllowed:
            return NetworkError.methodNotAllowed
        default:
            return NetworkError.requestFailed
        }
    }

    func createRequestURL(config: NetworkConfig) throws -> URL {
        let urlString = self.apiConfiguration.gatewayEndpoint + config.path + config.endPoint
        guard let requestURL = URL(string: urlString) else {
            throw NetworkError.missingURL
        }
        return requestURL
    }
}
