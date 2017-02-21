//
//  Classes.h
//  School
//
//  Created by zhaojw on 1/3/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClassesInfo, Students, Teacher;

NS_ASSUME_NONNULL_BEGIN

@interface Classes : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Classes+CoreDataProperties.h"
