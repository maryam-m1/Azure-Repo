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

/// Result of the create chat thread operation.
public struct CreateChatThreadResult: Codable, Equatable {
    // MARK: Properties

    /// Chat thread.
    public let chatThread: ChatThread?
    /// Errors encountered during the creation of the chat thread.
    public let errors: CreateChatThreadErrors?

    // MARK: Initializers

    /// Initialize a `CreateChatThreadResult` structure.
    /// - Parameters:
    ///   - chatThread: Chat thread.
    ///   - errors: Errors encountered during the creation of the chat thread.
    public init(
        chatThread: ChatThread? = nil, errors: CreateChatThreadErrors? = nil
    ) {
        self.chatThread = chatThread
        self.errors = errors
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case chatThread = "chatThread"
        case errors = "errors"
    }

    /// Initialize a `CreateChatThreadResult` structure from decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.chatThread = try? container.decode(ChatThread.self, forKey: .chatThread)
        self.errors = try? container.decode(CreateChatThreadErrors.self, forKey: .errors)
    }

    /// Encode a `CreateChatThreadResult` structure
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if chatThread != nil { try? container.encode(chatThread, forKey: .chatThread) }
        if errors != nil { try? container.encode(errors, forKey: .errors) }
    }
}
