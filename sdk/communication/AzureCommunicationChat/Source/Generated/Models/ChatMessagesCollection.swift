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

/// Collection of chat messages for a particular chat thread.
public struct ChatMessagesCollection: Codable {
    // MARK: Properties

    /// Collection of chat messages.
    internal let value: [ChatMessageInternal]
    /// If there are more chat messages that can be retrieved, the next link will be populated.
    public let nextLink: String?

    // MARK: Initializers

    /// Initialize a `ChatMessagesCollection` structure.
    /// - Parameters:
    ///   - value: Collection of chat messages.
    ///   - nextLink: If there are more chat messages that can be retrieved, the next link will be populated.
    internal init(
        value: [ChatMessageInternal], nextLink: String? = nil
    ) {
        self.value = value
        self.nextLink = nextLink
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case value = "value"
        case nextLink = "nextLink"
    }

    /// Initialize a `ChatMessagesCollection` structure from decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode([ChatMessageInternal].self, forKey: .value)
        self.nextLink = try? container.decode(String.self, forKey: .nextLink)
    }

    /// Encode a `ChatMessagesCollection` structure
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
        if nextLink != nil { try? container.encode(nextLink, forKey: .nextLink) }
    }
}
