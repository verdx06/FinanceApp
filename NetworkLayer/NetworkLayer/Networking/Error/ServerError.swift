//
//  ServerError.swift
//  NetworkLayer
//
//  Created by Виталий Багаутдинов on 09.12.2025.
//

import Foundation

public enum ServerError: LocalizedError
{
    case internalServerError
    case serviceUnavailable
    case authorizationRequired
    case accessForbidden
    case registrationNotConfirmed
    case userNotRegistered
    case entityNotFound
    case invalidOtp
    case incorrectData
    case resourceNotFound
    case emailAlreadyExists

    public var errorDescription: String? {
        switch self {
        case .internalServerError: "LocalizedKey.ServerErrorMessage.internalServerError"
        case .serviceUnavailable: "LocalizedKey.ServerErrorMessage.serviceUnavailable"
        case .authorizationRequired: "LocalizedKey.ServerErrorMessage.authorizationRequired"
        case .accessForbidden: "LocalizedKey.ServerErrorMessage.accessForbidden"
        case .registrationNotConfirmed: "LocalizedKey.ServerErrorMessage.registrationNotConfirmed"
        case .userNotRegistered: "LocalizedKey.ServerErrorMessage.userNotRegistered"
        case .entityNotFound: "LocalizedKey.ServerErrorMessage.entityNotFound"
        case .invalidOtp: "LocalizedKey.ServerErrorMessage.invalidOtp"
        case .incorrectData: "LocalizedKey.ServerErrorMessage.incorrectData"
        case .resourceNotFound: "LocalizedKey.ServerErrorMessage.resourceNotFound"
        case .emailAlreadyExists: "LocalizedKey.ServerErrorMessage.emailAlreadyExists"
        }
    }

    static func byCode(_ code: Int) -> Self? {
        switch code {
        case 100, 200, 300: .internalServerError
        case 101, 201, 301: .serviceUnavailable
        case 102: .authorizationRequired
        case 103, 203: .accessForbidden
        case 104: .registrationNotConfirmed
        case 105, 108: .userNotRegistered
        case 106: .entityNotFound
        case 202: .invalidOtp
        case 204, 303: .incorrectData
        case 302: .resourceNotFound
        case 304: .emailAlreadyExists
        default: nil
        }
    }
}

