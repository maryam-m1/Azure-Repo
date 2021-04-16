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
// swiftlint:disable file_length
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length
// swiftlint:disable type_body_length

public final class AzureCommunicationChatClient: PipelineClient, PageableClient {
    public func continuationUrl(forRequestUrl _: URL, withContinuationToken token: String) -> URL? {
        return URL(string: token)
    }

    /// API version of the  to invoke. Defaults to the latest.
    public enum ApiVersion: RequestStringConvertible {
        /// Custom value for unrecognized enum values
        case custom(String)
        /// API version "2021-03-07"
        case v20210307

        /// The most recent API version of the
        public static var latest: ApiVersion {
            return .v20210307
        }

        public var requestString: String {
            switch self {
            case let .custom(val):
                return val
            case .v20210307:
                return "2021-03-07"
            }
        }

        public init(_ val: String) {
            switch val.lowercased() {
            case "2021-03-07":
                self = .v20210307
            default:
                self = .custom(val)
            }
        }
    }

    /// Options provided to configure this `AzureCommunicationChatClient`.
    public let options: AzureCommunicationChatClientOptions

    // MARK: Initializers

    /// Create a AzureCommunicationChatClient client.
    /// - Parameters:
    ///   - endpoint: Base URL for the AzureCommunicationChatClient.
    ///   - authPolicy: An `Authenticating` policy to use for authenticating client requests.
    ///   - options: Options used to configure the client.
    public init(
        endpoint: URL,
        authPolicy: Authenticating,
        withOptions options: AzureCommunicationChatClientOptions
    ) throws {
        self.options = options
        super.init(
            endpoint: endpoint,
            transport: options.transportOptions.transport ?? URLSessionTransport(),
            policies: [
                UserAgentPolicy(for: AzureCommunicationChatClient.self, telemetryOptions: options.telemetryOptions),
                RequestIdPolicy(),
                AddDatePolicy(),
                authPolicy,
                ContentDecodePolicy(),
                LoggingPolicy(),
                NormalizeETagPolicy()
            ],
            logger: options.logger,
            options: options
        )
    }

    public lazy var chat = Chat(client: self)
    public lazy var chatThread = ChatThread(client: self)

    // MARK: Client Methods
}
