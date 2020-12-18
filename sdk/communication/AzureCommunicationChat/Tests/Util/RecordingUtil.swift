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

import AzureCore
import Foundation
import OHHTTPStubsSwift

class Recorder {
    /// Sanitizes response data.
    /// - Parameter data: The string to sanitize.
    private static func sanitize(data: String) throws -> String {
        // Sanitize ids
        var regex = try NSRegularExpression(pattern: "\\\"id\\\":\\\".*?\\\"", options: .caseInsensitive)
        var sanitized = regex.stringByReplacingMatches(
            in: data,
            range: NSRange(0 ..< data.utf16.count),
            withTemplate: "\\\"id\\\":\\\"sanitized\\\""
        )

        // Sanitize createdBy which is also an id
        regex = try NSRegularExpression(pattern: "\\\"createdBy\\\":\\\".*?\\\"", options: .caseInsensitive)
        sanitized = regex.stringByReplacingMatches(
            in: sanitized,
            range: NSRange(0 ..< sanitized.utf16.count),
            withTemplate: "\\\"createdBy\\\":\\\"sanitized\\\""
        )

        return sanitized
    }

    /// Writes an HTTPResponse to a file for playback.
    /// - Parameters:
    ///   - name: The name of the recording, used as the filename.
    ///   - httpResponse: The HTTPResponse returned by the request.
    public static func record(
        name: Recording,
        httpResponse: HTTPResponse?
    ) {
        guard let response = httpResponse else {
            return
        }

        do {
            // Get filepath
            var url = URL(fileURLWithPath: #filePath)
            url.deleteLastPathComponent()
            var path = url.path
            path.append("/Recordings/\(name).json")

            // Create recording file, will overwrite existing
            FileManager.default.createFile(atPath: path, contents: nil)

            // Get response body from data
            guard let responseData = String(data: response.data!, encoding: .utf8) else {
                return
            }

            // Remove ids from the response
            let sanitized = try sanitize(data: responseData)

            // Write response to file
            try sanitized.write(toFile: path, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }

    /// Register a stub for each ACS call
    public static func registerStubs() {
        for recording in Recording.allCases {
            register(stub: recording)
        }
    }

    /// Registers a stub for the given recording.
    /// - Parameter recording: The recording to stub
    private static func register(stub recording: Recording) {
        let bundle = Bundle(for: Self.self)
        let path = bundle.path(forResource: recording.rawValue, ofType: "json")!

        switch recording {
        case Recording.addParticipants:
            stub(condition: isMethodPOST() && pathEndsWith("/participants/:add")) { _ in
                fixture(filePath: path, status: 201, headers: nil)
            }

        case Recording.createThread:
            stub(condition: isMethodPOST() && pathEndsWith("/chat/threads")) { _ in
                fixture(filePath: path, status: 201, headers: nil)
            }

        case Recording.deleteMessage:
            stub(condition: isMethodDELETE() && pathMatches("//messages//")) { _ in
                fixture(filePath: path, status: 201, headers: nil)
            }

        case Recording.deleteThread:
            stub(condition: isMethodDELETE() && pathStartsWith("/chat/threads/")) { _ in
                fixture(filePath: path, status: 204, headers: nil)
            }

        case Recording.getMessage:
            stub(condition: isMethodGET() && pathMatches("//messages//")) { _ in
                fixture(filePath: path, status: 201, headers: nil)
            }

        case Recording.getThread:
            stub(condition: isMethodGET() && pathStartsWith("/chat/threads/")) { _ in
                fixture(filePath: path, status: 200, headers: nil)
            }

        case Recording.listParticipants:
            stub(condition: isMethodGET() && pathEndsWith("/participants")) { _ in
                fixture(filePath: path, status: 200, headers: nil)
            }

        case Recording.removeParticipant:
            stub(condition: isMethodDELETE() && pathMatches("//participants//")) { _ in
                fixture(filePath: path, status: 204, headers: nil)
            }

        case Recording.sendMessage:
            stub(condition: isMethodPOST() && pathEndsWith("/messages")) { _ in
                fixture(filePath: path, status: 201, headers: nil)
            }

        case Recording.sendReadReceipt:
            stub(condition: isMethodPOST() && pathEndsWith("/readReceipts")) { _ in
                fixture(filePath: path, status: 200, headers: nil)
            }

        case Recording.sendTypingNotification:
            stub(condition: isMethodPOST() && pathEndsWith("/typing")) { _ in
                fixture(filePath: path, status: 200, headers: nil)
            }

        case Recording.updateMessage:
            stub(condition: isMethodPATCH() && pathMatches("/messages/")) { _ in
                fixture(filePath: path, status: 204, headers: nil)
            }

        case Recording.updateTopic:
            stub(condition: isMethodPATCH() && pathStartsWith("/chat/threads")) { _ in
                fixture(filePath: path, status: 204, headers: nil)
            }
        }
    }
}

/// Names for stubbing network calls
enum Recording: String, CaseIterable {
    // ChatClient
    case createThread
    case getThread
    case deleteThread
    // ChatThreadClient
    case updateTopic
    case sendReadReceipt
    case sendTypingNotification
    case sendMessage
    case updateMessage
    case deleteMessage
    case getMessage
    case addParticipants
    case removeParticipant
    case listParticipants
}
