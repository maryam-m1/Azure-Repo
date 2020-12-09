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
import AzureCommunicationChat
import OHHTTPStubsSwift
import XCTest

// TODO: util function that generates JSON files from responses - run with each test if mode is record
func generateRecording() {
    // pass as completion handler to test calls
    // create() {\
//    .success(reponse)
//        completionHandler(response)
//    }
//     completionHandler = generateRecording for record mode, nil for other modes
    // assign the completion handler during setup function bf each test?
}

// TODO: util function that registers all the stubs - in test setup class func run at start of all tests if mode is playback
func registerStubs() {}

class ChatClientTests: XCTestCase {
    private var chatClient: ChatClient!
    private var validId: String!
    private var participant: ChatParticipant!
    private var threadTopic: String = "General"
    private let timeout: TimeInterval = 10.0

    override func setUp() {
        super.setUp()

        guard let endpoint = ProcessInfo.processInfo.environment["AZURE_COMMUNICATION_ENDPOINT"] else {
            XCTFail("Failed to retrieve endpoint")
            return
        }

        guard let token = ProcessInfo.processInfo.environment["AZURE_COMMUNICATION_TOKEN"] else {
            XCTFail("Failed to retrieve token")
            return
        }

        guard let credential = try? CommunicationUserCredential(token: token) else {
            XCTFail("Failed to create credential")
            return
        }

        let options = AzureCommunicationChatClientOptions()

        guard let client = try? ChatClient(endpoint: endpoint, credential: credential, withOptions: options) else {
            XCTFail("Failed to initialize ChatClient")
            return
        }

        chatClient = client

        guard let userId = ProcessInfo.processInfo.environment["AZURE_COMMUNICATION_USER_ID"] else {
            XCTFail("Failed to retrieve user ID")
            return
        }

        validId = userId

        participant = ChatParticipant(
            id: validId,
            displayName: "Initial Member"
        )
    }

    func createThread(completionHandler: @escaping (String) -> Void) {
        let thread = CreateChatThreadRequest(
            topic: threadTopic,
            participants: [
                participant
            ]
        )

        chatClient.create(thread: thread) { result, _ in
            switch result {
            case let .success(chatThreadResult):
                guard let threadId = chatThreadResult.chatThread?.id else {
                    XCTFail("Failed to get thread id")
                    return
                }

                completionHandler(threadId)
            case let .failure(error):
                XCTFail("Error creating thread: \(error)")
            }
        }
    }

    func test_CreateThread_ResultContainsChatThread() {
        // TODO: Move this into setup code
//        let bundle = Bundle(for: type(of: self))
//        let path = bundle.path(forResource: "test", ofType: "json") ?? ""
//
//        /// This registers the stub and returns the response inside the JSON file at path
//        stub(condition: isMethodPOST() && isPath("/chat/threads")) { _ in
//            return fixture(filePath: path, status: 201, headers: nil)
//        }

        let thread = CreateChatThreadRequest(
            topic: threadTopic,
            participants: [
                participant
            ]
        )

        let expectation = self.expectation(description: "Create thread")

        chatClient.create(thread: thread) { result, _ in
            switch result {
            case let .success(response):
                guard let chatThread = response.chatThread else {
                    XCTFail("Create thread failed to return chatThread")
                    return
                }

                // XCTAssert(chatThread.id == "some_id")
                XCTAssert(chatThread.id != nil)
                XCTAssert(chatThread.topic == thread.topic)
                XCTAssert(chatThread.createdBy == self.participant.id)

            case let .failure(error):
                XCTFail("Create thread failed with error: \(error)")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: timeout) { error in
            if let error = error {
                XCTFail("Create thread timed out: \(error)")
            }
        }
    }

    func test_GetThread_ReturnsChatThread() {
        let expectation = self.expectation(description: "Get thread")

        createThread { threadId in
            self.chatClient.get(thread: threadId) { result, _ in
                switch result {
                case let .success(thread):
                    XCTAssert(thread.topic == "General")

                case let .failure(error):
                    XCTFail("Get thread failed with error: \(error)")
                }

                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: timeout) { error in
            if let error = error {
                XCTFail("Get thread timed out: \(error)")
            }
        }
    }

    func test_ListThreads_ReturnsChatThreadInfos() {
        let expectation = self.expectation(description: "List threads")

        createThread { _ in
            self.chatClient.listThreads { result, _ in
                switch result {
                case let .success(threads):
                    threads.nextItem { result in
                        switch result {
                        case let .success(item):
                            XCTAssert(item.topic == self.threadTopic)

                        case let .failure(error):
                            XCTFail("List threads failed to return threadInfo: \(error)")
                        }

                        expectation.fulfill()
                    }

                case let .failure(error):
                    XCTFail("List threads failed with error: \(error)")
                }
            }
        }

        waitForExpectations(timeout: timeout) { error in
            if let error = error {
                XCTFail("List thread timed out: \(error)")
            }
        }
    }

    func test_DeleteThread() {
        let expectation = self.expectation(description: "Delete thread")

        createThread { threadId in
            self.chatClient.delete(thread: threadId) { result, _ in
                self.chatClient.get(thread: threadId) { result, _ in
                    switch result {
                    case let .success(thread):
                        XCTAssertNotNil(thread.deletedOn)

                    case let .failure(error):
                        XCTFail("Deleted thread failed with error: \(error)")
                    }

                    expectation.fulfill()
                }
            }
        }

        waitForExpectations(timeout: timeout) { error in
            if let error = error {
                XCTFail("Delete thread timed out: \(error)")
            }
        }
    }
}
