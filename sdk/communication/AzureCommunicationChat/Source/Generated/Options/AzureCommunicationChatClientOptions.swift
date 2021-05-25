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

/// User-configurable client options.
public struct AzureCommunicationChatClientOptions: ClientOptions {
    /// The API version of the client to invoke.
    public let apiVersion: String
    /// The `ClientLogger` to be used by this client.
    public let logger: ClientLogger
    /// Options for configuring telemetry sent by this client.
    public let telemetryOptions: TelemetryOptions
    /// Global transport options
    public let transportOptions: TransportOptions
    /// The default dispatch queue on which to call all completion handler. Defaults to `DispatchQueue.main`.
    public let dispatchQueue: DispatchQueue?

    /// API version of the  to invoke. Defaults to the latest.
    public enum ApiVersion: RequestStringConvertible {
        /// Custom value for unrecognized enum values
        case custom(String)
        /// API version "2021-04-05-preview6"
        case v20210405preview6

        /// The most recent API version of the
        public static var latest: ApiVersion {
            return .v20210405preview6
        }

        public var requestString: String {
            switch self {
            case let .custom(val):
                return val
            case .v20210405preview6:
                return "2021-04-05-preview6"
            }
        }

        public init(_ val: String) {
            switch val.lowercased() {
            case "2021-04-05-preview6":
                self = .v20210405preview6
            default:
                self = .custom(val)
            }
        }
    }

    /// Initialize a `AzureCommunicationChatClientOptions` structure.
    /// - Parameters:
    ///   - apiVersion: The API version of the client to invoke.
    ///   - logger: The `ClientLogger` to be used by this client.
    ///   - telemetryOptions: Options for configuring telemetry sent by this client.
    ///   - cancellationToken: A token used to make a best-effort attempt at canceling a request.
    ///   - dispatchQueue: The default dispatch queue on which to call all completion handler. Defaults to `DispatchQueue.main`.
    public init(
        apiVersion: AzureCommunicationChatClientOptions.ApiVersion = .latest,
        logger: ClientLogger = ClientLoggers.default(tag: "AzureCommunicationChat"),
        telemetryOptions: TelemetryOptions = TelemetryOptions(),
        transportOptions: TransportOptions? = nil,
        dispatchQueue: DispatchQueue? = nil
    ) {
        self.apiVersion = apiVersion.requestString
        self.logger = logger
        self.telemetryOptions = telemetryOptions
        self.transportOptions = transportOptions ?? TransportOptions()
        self.dispatchQueue = dispatchQueue
    }
}
