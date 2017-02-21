//
//  Students+CoreDataProperties.h
//  School
//
//  Created by zhaojw on 1/2/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Students.h"

NS_ASSUME_NONNULL_BEGIN

@interface Students (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) int16_t id;
@property (nullable, nonatomic, retain) Profile *profile;
@property (nullable, nonatomic, retain) Classes *classes;
@property (nullable, nonatomic, retain) NSSet<Subjects *> *subjects;

@end

@interface Students (CoreDataGeneratedAccessors)

- (void)addSubjectsObject:(Subjects *)value;
- (void)removeSubjectsObject:(Subjects *)value;
- (void)addSubjects:(NSSet<Subjects *> *)values;
- (void)removeSubjects:(NSSet<Subjects *> *)values;

@end

NS_ASSUME_NONNULL_END
