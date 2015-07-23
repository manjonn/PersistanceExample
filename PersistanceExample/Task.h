//
//  Task.h
//  PersistanceExample
//
//  Created by Manjula Jonnalagadda on 7/22/15.
//  Copyright (c) 2015 Manjula Jonnalagadda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * taskName;
@property (nonatomic, retain) NSString * taskDescription;
@property (nonatomic, retain) NSDate * deadLine;

@end
