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

public struct ChatThread: Codable {
    // MARK: Properties

    /// Chat thread id.
    public let id: String?
    /// Chat thread topic.
    public let topic: String?
    /// The timestamp when the chat thread was created. The timestamp is in ISO8601 format: `yyyy-MM-ddTHH:mm:ssZ`.
    public let createdOn: Iso8601Date?
    /// Id of the chat thread owner.
    public let createdBy: String?
    /// Chat thread members.
    public let members: [ChatThreadMember]?

    // MARK: Initializers

    /// Initialize a `ChatThread` structure.
    /// - Parameters:
    ///   - id: Chat thread id.
    ///   - topic: Chat thread topic.
    ///   - createdOn: The timestamp when the chat thread was created. The timestamp is in ISO8601 format: `yyyy-MM-ddTHH:mm:ssZ`.
    ///   - createdBy: Id of the chat thread owner.
    ///   - members: Chat thread members.
    public init(
        id: String? = nil, topic: String? = nil, createdOn: Iso8601Date? = nil, createdBy: String? = nil,
        members: [ChatThreadMember]? = nil
    ) {
        self.id = id
        self.topic = topic
        self.createdOn = createdOn
        self.createdBy = createdBy
        self.members = members
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id
        case topic
        case createdOn
        case createdBy
        case members
    }

    /// Initialize a `ChatThread` structure from decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
        self.topic = try? container.decode(String.self, forKey: .topic)
        if let dateString = try? container.decode(String.self, forKey: .createdOn) {
            self.createdOn = Date(dateString, format: Date.Format.iso8601)
        } else {
            self.createdOn = nil
        }
        self.createdBy = try? container.decode(String.self, forKey: .createdBy)
        self.members = try? container.decode([ChatThreadMember].self, forKey: .members)
    }

    /// Encode a `ChatThread` structure
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if id != nil { try? container.encode(id, forKey: .id) }
        if topic != nil { try? container.encode(topic, forKey: .topic) }
        if createdOn != nil {
            let dateFormatter = DateFormatter()
            let dateString = dateFormatter.string(from: createdOn!)
            try? container.encode(dateString, forKey: .createdOn)
        }

        if createdBy != nil { try? container.encode(createdBy, forKey: .createdBy) }
        if members != nil { try? container.encode(members, forKey: .members) }
    }
}
