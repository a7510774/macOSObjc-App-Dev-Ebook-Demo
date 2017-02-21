//
//  Teacher+CoreDataProperties.h
//  School
//
//  Created by zhaojw on 1/3/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Teacher.h"

NS_ASSUME_NONNULL_BEGIN

@interface Teacher (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *adminClass;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Classes *adminClasses;

@end

NS_ASSUME_NONNULL_END
