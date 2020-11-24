// --------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.
// --------------------------------------------------------------------------

import AzureCore
import Foundation
// swiftlint:disable superfluous_disable_command
// swiftlint:disable identifier_name
// swiftlint:disable line_length
// swiftlint:disable cyclomatic_complexity

public struct ErrorType: Codable, Swift.Error {
    // MARK: Properties

    /// Error code
    public let code: String?
    /// Description of the error
    public let message: String?
    /// If applicable, would be used to indicate the property causing the error
    public let target: String?
    /// If applicable, inner errors would be returned for more details on the error
    public let innerErrors: [ErrorType]?

    // MARK: Initializers

    /// Initialize a `ErrorType` structure.
    /// - Parameters:
    ///   - code: Error code
    ///   - message: Description of the error
    ///   - target: If applicable, would be used to indicate the property causing the error
    ///   - innerErrors: If applicable, inner errors would be returned for more details on the error
    public init(
        code: String? = nil, message: String? = nil, target: String? = nil, innerErrors: [ErrorType]? = nil
    ) {
        self.code = code
        self.message = message
        self.target = target
        self.innerErrors = innerErrors
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case message = "message"
        case target = "target"
        case innerErrors = "innerErrors"
    }

    /// Initialize a `ErrorType` structure from decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try? container.decode(String.self, forKey: .code)
        self.message = try? container.decode(String.self, forKey: .message)
        self.target = try? container.decode(String.self, forKey: .target)
        self.innerErrors = try? container.decode([ErrorType].self, forKey: .innerErrors)
    }

    /// Encode a `ErrorType` structure
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if code != nil { try? container.encode(code, forKey: .code) }
        if message != nil { try? container.encode(message, forKey: .message) }
        if target != nil { try? container.encode(target, forKey: .target) }
        if innerErrors != nil { try? container.encode(innerErrors, forKey: .innerErrors) }
    }
}
