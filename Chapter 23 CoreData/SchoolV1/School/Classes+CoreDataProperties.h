//
//  Classes+CoreDataProperties.h
//  School
//
//  Created by zhaojw on 1/2/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Classes.h"

NS_ASSUME_NONNULL_BEGIN

@interface Classes (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nonatomic) int16_t studentsNum;
@property (nullable, nonatomic, retain) NSSet<Students *> *classStudents;

@end

@interface Classes (CoreDataGeneratedAccessors)

- (void)addClassStudentsObject:(Students *)value;
- (void)removeClassStudentsObject:(Students *)value;
- (void)addClassStudents:(NSSet<Students *> *)values;
- (void)removeClassStudents:(NSSet<Students *> *)values;

@end

NS_ASSUME_NONNULL_END
