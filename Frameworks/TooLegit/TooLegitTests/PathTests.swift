//
// Copyright (C) 2016-present Instructure, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
    
    

import XCTest
import TooLegit

class PathTests: XCTestCase {

    func testBuildingPathsFromStrings() {
        let basePath = api/v1
        XCTAssertEqual("api/v1", basePath)

        XCTAssertEqual("api/v1/users", basePath/"users")
        XCTAssertEqual("api/v1/users/foo/bar", api/v1/"users"/"foo"/"bar")
    }

    func testBuildingPathsFromURL() {
        let baseURL = NSURL(string: "http://api.com")!
        XCTAssertEqual("http://api.com/users", (baseURL/"users").absoluteString)
    }

    func testBuildingPathFromInt() {
        XCTAssertEqual("api/v1/courses/1", api/v1/"courses"/1)
    }

}
