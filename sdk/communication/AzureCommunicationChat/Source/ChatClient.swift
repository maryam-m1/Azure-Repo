// --------------------------------------------------------------------------
//
// Copyright (c) Microsoft Corporation. All rights reserved.
//
// The MIT License (MIT)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the ""Software""), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//
// --------------------------------------------------------------------------

import AzureCommunication
import AzureCore
import Foundation

public class ChatClient {
    // MARK: Properties

    private let client: AzureCommunicationChatClient
    private let credential: CommunicationUserCredential
    private let endpoint: String
    private let options: AzureCommunicationChatClientOptions

    // MARK: Initializers

    /// Create a ChatClient.
    /// - Parameters:
    ///   - endpoint: The Communication Services endpoint.
    ///   - credential: The user credential.
    ///   - options: Options used to configure the client.
    public init(
        endpoint: String,
        credential: CommunicationUserCredential,
        withOptions options: AzureCommunicationChatClientOptions
    ) throws {
        self.endpoint = endpoint
        self.credential = credential
        self.options = options

        guard let endpointUrl = URL(string: endpoint) else {
            throw AzureError.client("Unable to form base URL.")
        }

        let authPolicy = CommunicationUserCredentialPolicy(credential: credential)

        self.client = try AzureCommunicationChatClient(endpoint: endpointUrl, authPolicy: authPolicy, withOptions: options)
    }

    // MARK: Public Methods

    /// Create a ChatThreadClient for the ChatThread with id threadId.
    /// - Parameters:
    ///   - threadId: The threadId.
    public func createClient(forChatThread threadId: String) throws -> ChatThreadClient {
        return try ChatThreadClient(
            threadId: threadId,
            endpoint: endpoint,
            credential: credential,
            withOptions: options
        )
    }

    /// Create a new ChatThread and return the ChatThreadClient for it.
    /// - Parameters:
    ///   - request: Request for creating a chat thread with the topic and members to add.
    ///   - withOptions: Create chat thread options.
    ///   - completionHandler: A completion handler that receives a ChatThreadClient on success.
    public func create(
        chatThread: CreateChatThreadRequest,
        withOptions options: AzureCommunicationChatService.CreateChatThreadOptions? = nil,
        completionHandler: @escaping HTTPResultHandler<ChatThreadClient>
    ) {
        client.create(chatThread: chatThread, withOptions: options) { result, httpResponse in
            do {
                switch result {
                case let .success(chatThread):
                    guard let threadId = chatThread.id else {
                        throw AzureError.service("Service response does not contain ThreadId.")
                    }

                    // Create and return a ChatThreadClient for the successfully created ChatThread
                    let chatThreadClient = try ChatThreadClient(
                        threadId: threadId,
                        endpoint: self.endpoint,
                        credential: self.credential,
                        withOptions: self.options
                    )
                    
                    completionHandler(.success(chatThreadClient), httpResponse)

                case let .failure(error):
                    throw error
                }
            } catch {
                let azureError = AzureError.client("Failed to create ChatThread.", error)
                completionHandler(.failure(azureError), httpResponse)
            }
        }
    }

    /// Get a ChatThread with id chatThreadId.
    /// - Parameters:
    ///   - chatThreadId: The chat thread id.
    ///   - withOptions: Get chat thread options.
    ///   - completionHandler: A completion handler that receives the chat thread on success.
    public func get(
        chatThreadId: String,
        withOptions options: AzureCommunicationChatService.GetChatThreadOptions? = nil,
        completionHandler: @escaping HTTPResultHandler<ChatThread>
    ) {
        client.getChatThread(chatThreadId: chatThreadId, withOptions: options) { result, httpResponse in
            switch result {
            case let .success(chatThread):
                completionHandler(.success(chatThread), httpResponse)

            case let .failure(error):
                completionHandler(.failure(error), httpResponse)
            }
        }
    }

    /// Gets the list of ChatThreads for the user.
    /// - Parameters:
    ///   - withOptions: List chat threads options.
    ///   - completionHandler: A completion handler that receives the list of chat thread info on success.
    public func list(
        withOptions options: AzureCommunicationChatService.ListChatThreadsOptions? = nil,
        completionHandler: @escaping HTTPResultHandler<PagedCollection<ChatThreadInfo>>
    ) {
        client.listChatThreads(withOptions: options) { result, httpResponse in
            switch result {
            case let .success(chatThreads):
                completionHandler(.success(chatThreads), httpResponse)

            case let .failure(error):
                completionHandler(.failure(error), httpResponse)
            }
        }
    }

    /// Delete the ChatThread with id chatThreadId.
    /// - Parameters:
    ///   - chatThreadId: The chat thread id.
    ///   - withOptions: Delete chat thread options.
    ///   - completionHandler: A completion handler.
    public func delete(
        chatThreadId: String,
        withOptions options: AzureCommunicationChatService.DeleteChatThreadOptions? = nil,
        completionHandler: @escaping HTTPResultHandler<Void>
    ) {
        client.deleteChatThread(chatThreadId: chatThreadId, withOptions: options) { result, httpResponse in
            switch result {
            case .success:
                completionHandler(.success(()), httpResponse)

            case let .failure(error):
                completionHandler(.failure(error), httpResponse)
            }
        }
    }
}
