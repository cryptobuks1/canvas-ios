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
    
    

import TooLegit

extension Session {
    static func build(baseURL baseURL: String = "http://google.com",
                      userID: String = "1",
                      userName: String = "john",
                      token: String? = nil,
                      masqueradeAsUserID: String? = nil,
                      localStoreDirectory: Session.LocalStoreDirectory = .Default) -> Session {
        let url = NSURL(string: baseURL)!
        let user = SessionUser(id: userID, name: userName)
        return Session(baseURL: url, user: user, token: token, localStoreDirectory: localStoreDirectory, masqueradeAsUserID: masqueradeAsUserID)
    }
}
