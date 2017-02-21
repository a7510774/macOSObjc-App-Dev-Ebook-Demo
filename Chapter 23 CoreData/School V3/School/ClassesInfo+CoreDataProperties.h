//
//  ClassesInfo+CoreDataProperties.h
//  School
//
//  Created by zhaojw on 1/3/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ClassesInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ClassesInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *photo;
@property (nullable, nonatomic, retain) NSData *video;
@property (nullable, nonatomic, retain) NSString *motto;
@property (nullable, nonatomic, retain) Classes *belongToClass;

@end

NS_ASSUME_NONNULL_END
