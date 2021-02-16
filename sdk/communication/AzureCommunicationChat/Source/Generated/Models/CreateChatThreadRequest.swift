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

/// Request payload for creating a chat thread.
public struct CreateChatThreadRequest: Codable, Equatable {
    // MARK: Properties

    /// The chat thread topic.
    public let topic: String
    /// Participants to be added to the chat thread.
    public let participants: [ChatParticipant]

    // MARK: Initializers

    /// Initialize a `CreateChatThreadRequest` structure.
    /// - Parameters:
    ///   - topic: The chat thread topic.
    ///   - participants: Participants to be added to the chat thread.
    public init(
        topic: String, participants: [ChatParticipant]
    ) {
        self.topic = topic
        self.participants = participants
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case topic = "topic"
        case participants = "participants"
    }

    /// Initialize a `CreateChatThreadRequest` structure from decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.topic = try container.decode(String.self, forKey: .topic)
        self.participants = try container.decode([ChatParticipant].self, forKey: .participants)
    }

    /// Encode a `CreateChatThreadRequest` structure
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(topic, forKey: .topic)
        try container.encode(participants, forKey: .participants)
    }
}
