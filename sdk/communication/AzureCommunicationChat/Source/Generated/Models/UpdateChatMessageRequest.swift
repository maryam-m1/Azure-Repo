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

public struct UpdateChatMessageRequest: Codable, Equatable {
    // MARK: Properties

    /// Chat message content.
    public let content: String?
    /// The chat message priority.
    public let priority: ChatMessagePriority?

    // MARK: Initializers

    /// Initialize a `UpdateChatMessageRequest` structure.
    /// - Parameters:
    ///   - content: Chat message content.
    ///   - priority: The chat message priority.
    public init(
        content: String? = nil, priority: ChatMessagePriority? = nil
    ) {
        self.content = content
        self.priority = priority
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case content = "content"
        case priority = "priority"
    }

    /// Initialize a `UpdateChatMessageRequest` structure from decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.content = try? container.decode(String.self, forKey: .content)
        self.priority = try? container.decode(ChatMessagePriority.self, forKey: .priority)
    }

    /// Encode a `UpdateChatMessageRequest` structure
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if content != nil { try? container.encode(content, forKey: .content) }
        if priority != nil { try? container.encode(priority, forKey: .priority) }
    }
}
