//
// Copyright (C) 2016-present Instructure, Inc.
//   
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, version 3 of the License.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
    
    

import Foundation
import TooLegit
import ReactiveCocoa
import Marshal

extension Student {
    public static func addStudent(session: Session, parentID: String, domain: NSURL) throws -> SignalProducer<(), NSError> {
        let request = try AirwolfAPI.addStudentRequest(session, parentID: parentID, studentDomain: domain)
        return session.emptyResponseSignalProducer(request)
    }

    public static func checkDomain(session: Session, parentID: String, domain: NSURL) throws -> SignalProducer<(), NSError> {
        let request = try AirwolfAPI.checkDomainRequest(session, parentID: parentID, studentDomain: domain)
        return session.emptyResponseSignalProducer(request)
    }

    public static func getStudents(session: Session, parentID: String) throws -> SignalProducer<[JSONObject], NSError> {
        let request = try AirwolfAPI.getStudentsRequest(session, parentID: parentID)
        return session.paginatedJSONSignalProducer(request)
    }

    public static func deleteStudent(session: Session, parentID: String, studentID: String) throws -> SignalProducer<(), NSError> {
        let request = try AirwolfAPI.deleteStudentRequest(session, parentID: parentID, studentID: studentID)
        return session.emptyResponseSignalProducer(request)
    }
}