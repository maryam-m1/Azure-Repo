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

/// Participants to be added to the thread.
internal struct AddChatParticipantsRequestInternal: Codable {
    // MARK: Properties

    /// Participants to add to a chat thread.
    internal let participants: [ChatParticipantInternal]

    // MARK: Initializers

    /// Initialize a `AddChatParticipantsRequestInternal` structure.
    /// - Parameters:
    ///   - participants: Participants to add to a chat thread.
    internal init(
        participants: [ChatParticipantInternal]
    ) {
        self.participants = participants
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case participants = "participants"
    }

    /// Initialize a `AddChatParticipantsRequestInternal` structure from decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.participants = try container.decode([ChatParticipantInternal].self, forKey: .participants)
    }

    /// Encode a `AddChatParticipantsRequestInternal` structure
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(participants, forKey: .participants)
    }
}