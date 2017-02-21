//
//  Subjects+CoreDataProperties.h
//  School
//
//  Created by zhaojw on 1/2/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Subjects.h"

NS_ASSUME_NONNULL_BEGIN

@interface Subjects (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) int16_t sid;
@property (nullable, nonatomic, retain) NSSet<Students *> *subjectStudents;

@end

@interface Subjects (CoreDataGeneratedAccessors)

- (void)addSubjectStudentsObject:(Students *)value;
- (void)removeSubjectStudentsObject:(Students *)value;
- (void)addSubjectStudents:(NSSet<Students *> *)values;
- (void)removeSubjectStudents:(NSSet<Students *> *)values;

@end

NS_ASSUME_NONNULL_END
