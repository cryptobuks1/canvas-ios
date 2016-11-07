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

#import "CSGLogFormatter.h"

@implementation CSGLogFormatter

- (NSString*)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString* logLevel = nil;
    switch (logMessage->_level) {
        case DDLogLevelError:
            logLevel = @"E";
            break;
        case DDLogLevelWarning:
            logLevel = @"W";
            break;
        case DDLogLevelInfo:
            logLevel = @"I";
            break;
        case DDLogLevelDebug:
            logLevel = @"D";
            break;
        default:
            logLevel = @"V";
            break;
    }
    
    return [NSString stringWithFormat:@"[%@][%@ %@][Line %lu] %@",
            logLevel,
            logMessage.fileName,
            logMessage.function,
            (unsigned long)logMessage->_line,
            logMessage->_message];
}

@end
