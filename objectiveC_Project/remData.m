//
//  remData.m
//  objectiveC_Project
//
//  Created by Abdelrahman on 19/01/2023.
//

#import "remData.h"

@implementation remData

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_remName forKey:@"remName"];
    [coder encodeObject:_remDescription forKey:@"remDescription"];
    [coder encodeObject:_remPriority forKey:@"remPriority"];
    [coder encodeObject:_remDate forKey:@"remDate"];
    [coder encodeObject:_remImg forKey:@"remImg"];
    [coder encodeObject:_remState forKey:@"remState"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
   self.remName =  [coder decodeObjectForKey:@"remName"];
    self.remDescription = [coder decodeObjectForKey:@"remDescription"];
    self.remPriority = [coder decodeObjectForKey:@"remPriority"];
    self.remDate = [coder decodeObjectForKey:@"remDate"];
    self.remImg = [coder decodeObjectForKey:@"remImg"];
    self.remState = [coder decodeObjectForKey:@"remState"];
    return  self;
}

@end
