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
    
    

@testable import CalendarKit
import SoAutomated
import TooLegit
import DoNotShipThis
import Marshal
import CoreData

extension CalendarEvent {
    static var validJSON: JSONObject {
        let bundle = NSBundle(forClass: CalendarEventTests.self)
        let path = bundle.pathForResource("calendar_event", ofType: "json")!
        return try! JSONParser.JSONObjectWithData(NSData(contentsOfFile: path)!)
    }

    static var validAssignmentJSON: JSONObject {
        let bundle = NSBundle(forClass: CalendarEventTests.self)
        let path = bundle.pathForResource("calendar_event_assignment", ofType: "json")!
        return try! JSONParser.JSONObjectWithData(NSData(contentsOfFile: path)!)
    }

    static func build(
        context: NSManagedObjectContext,
        id: String = "1",
        title: String? = nil,
        startAt: NSDate? = nil,
        endAt: NSDate? = nil,
        htmlDescription: String? = nil,
        locationName: String? = nil,
        locationAddress: String? = nil,
        contextCode: String = "user_6782429",
        effectiveContextCode: String? = nil,
        rawWorkflowState: String = "active",
        hidden: Bool = false,
        url: NSURL = NSURL(string: "https://mobiledev.instructure.com/api/v1/calendar_events/2724235")!,
        htmlURL: NSURL = NSURL(string: "https://mobiledev.instructure.com/calendar?event_id=2724235&include_contexts=user_6782429")!,
        allDayDate: String = "2016-01-11",
        allDay: Bool = true,
        createdAt: NSDate = NSDate(),
        updatedAt: NSDate = NSDate(),
        rawType: String = "event",
        hasSubmitted: Bool = false,
        rawSubmissionTypes: Int32 = 0,
        assignmentID: String? = nil,
        discussionTopicID: String? = nil,
        quizID: String? = nil,
        courseID: String? = nil,
        currentGrade: String? = nil,
        currentScore: NSNumber? = nil,
        pointsPossible: NSNumber? = nil,
        submissionLate: Bool = false,
        submittedAt: NSDate? = nil,
        submissionExcused: Bool = false,
        gradedAt: NSDate? = nil,
        rawStatus: Int64 = 0
    ) -> CalendarEvent {
        let calendarEvent = CalendarEvent(inContext: context)
        calendarEvent.id = id
        calendarEvent.title = title
        calendarEvent.startAt = startAt
        calendarEvent.endAt = endAt
        calendarEvent.htmlDescription = htmlDescription
        calendarEvent.locationName = locationName
        calendarEvent.locationAddress = locationAddress
        calendarEvent.contextCode = contextCode
        calendarEvent.effectiveContextCode = effectiveContextCode
        calendarEvent.rawWorkflowState = rawWorkflowState
        calendarEvent.hidden = hidden
        calendarEvent.url = url
        calendarEvent.htmlURL = htmlURL
        calendarEvent.allDayDate = allDayDate
        calendarEvent.allDay = allDay
        calendarEvent.createdAt = createdAt
        calendarEvent.updatedAt = updatedAt
        calendarEvent.rawType = rawType
        calendarEvent.hasSubmitted = hasSubmitted
        calendarEvent.rawSubmissionTypes = rawSubmissionTypes
        calendarEvent.assignmentID = assignmentID
        calendarEvent.discussionTopicID = discussionTopicID
        calendarEvent.quizID = quizID
        calendarEvent.courseID = courseID
        calendarEvent.currentGrade = currentGrade
        calendarEvent.currentScore = currentScore
        calendarEvent.pointsPossible = pointsPossible
        calendarEvent.submissionLate = submissionLate
        calendarEvent.submittedAt = submittedAt
        calendarEvent.submissionExcused = submissionExcused
        calendarEvent.gradedAt = gradedAt
        calendarEvent.rawStatus = rawStatus
        return calendarEvent
    }
}
