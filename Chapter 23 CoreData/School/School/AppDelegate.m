//
//  AppDelegate.m
//  School
//
//  Created by zhaojw on 1/2/16.
//  Copyright © 2016 MacDev.io. All rights reserved.
//

#import "AppDelegate.h"
#import "Classes+CoreDataProperties.h"
#import "Students+CoreDataProperties.h"
#import "Profile+CoreDataProperties.h"
@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
- (IBAction)saveAction:(id)sender;
@property (weak) IBOutlet NSArrayController *arrayController;
@property (weak) IBOutlet NSTableView *tableView;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    
    NSArrayController *arrayController = [self arrayController];
    NSError *error = nil;
    BOOL ok = [arrayController fetchWithRequest:nil merge:NO error:&error];
    if (ok == NO) {
        NSLog(@"Failed to perform fetch: %@", error);
        abort();
    }
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *ClsInfoEn =  [NSEntityDescription entityForName:@"ClassesInfo"  inManagedObjectContext:self.managedObjectContext];
    [request setEntity:ClsInfoEn];
    // NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!error){
        NSLog(@"ClassesInfo count %ld ",[array count]);
    }

    
        
}

- (IBAction)uploadPhotoAction:(id)sender {
    NSInteger selectionIndex = self.tableView.selectedRow;
    if(selectionIndex<0){
        return;
    }
    [self openSelectClassPhotoFilePanel];
}

-(void)openSelectClassPhotoFilePanel {
    NSOpenPanel *openDlg = [NSOpenPanel openPanel];
    openDlg.canChooseFiles = YES ;
    openDlg.canChooseDirectories = NO;
    openDlg.allowsMultipleSelection = NO;
    openDlg.allowedFileTypes = @[@"png",@"jpeg"];
    [openDlg beginWithCompletionHandler: ^(NSInteger result){
        if(result==NSFileHandlingPanelOKButton){
            NSArray *fileURLs = [openDlg URLs];
            for(NSURL *url in fileURLs) {
                
                NSImage *image = [[NSImage alloc]initWithContentsOfURL:url];
                ;
                NSArray *imageRepresentations = [image representations];
                NSData *imageData = [NSBitmapImageRep
                                     representationOfImageRepsInArray:imageRepresentations
                                     usingType:NSPNGFileType
                                     properties:@{}];
                
                NSInteger selectionIndex = self.tableView.selectedRow;
                if(selectionIndex<0){
                    return;
                }
                NSArray *arrangedObjects = self.arrayController.arrangedObjects;
                if(selectionIndex > [arrangedObjects count]-1){
                    return;
                }
                Classes *classObj = self.arrayController.arrangedObjects[selectionIndex];
                //classObj.photo = imageData;
            }
        }
        
    }];
}



- (IBAction)undoAction:(id)sender {
    [self.managedObjectContext.undoManager undo];
}

- (IBAction)redoAction:(id)sender {
    [self.managedObjectContext.undoManager redo];
}

- (void)applicationDidFinishLaunching2:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
//    Classes *class = [NSEntityDescription insertNewObjectForEntityForName:@"Classes" inManagedObjectContext:self.managedObjectContext];
//    
//    class.title = @"Class 3";
//    class.studentsNum =20;
//   
//    
//    [self saveAction:nil];
//    
//    
//    [self.managedObjectContext deleteObject:class];
    
    
    
    NSArrayController *arrayController = [self arrayController];
    NSError *error = nil;
    BOOL ok = [arrayController fetchWithRequest:nil merge:NO error:&error];
    if (ok == NO) {
        NSLog(@"Failed to perform fetch: %@", error);
        abort();
    }
    
    return;
    
    
    Students *student = [NSEntityDescription insertNewObjectForEntityForName:@"Students" inManagedObjectContext:self.managedObjectContext];
    student.name = @"zhaojw";
    student.id = 1;
    
    
    Profile *profile = [NSEntityDescription insertNewObjectForEntityForName:@"Profile" inManagedObjectContext:self.managedObjectContext];
    profile.address = @"beijing";
    profile.homephone = @"18656776754";
    
    student.profile = profile;
    profile.student = student;
    
    [self saveAction:nil];
    
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *StudentEn =  [NSEntityDescription entityForName:@"Students"  inManagedObjectContext:self.managedObjectContext];
    [request setEntity:StudentEn];
   // NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];

    if(!error){
        NSLog(@"Students count %ld ",[array count]);
    }
    
    
    NSEntityDescription *profileEn =  [NSEntityDescription entityForName:@"Profile"  inManagedObjectContext:self.managedObjectContext];
    [request setEntity:profileEn];

    array = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!error){
        NSLog(@"Profile count %ld ",[array count]);
    }
    
    
    [request setEntity:profileEn];
    
    array = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!error){
        for(Profile *pro in array){
            [self.managedObjectContext deleteObject:pro];
        }
    }
    
    
    [request setEntity:StudentEn];
    
    array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if(!error){
        NSLog(@"Students 2 count %ld ",[array count]);
    }
    
    [request setEntity:profileEn];
    
    array = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if(!error){
        NSLog(@"Profile 2 count %ld ",[array count]);
    }
    
    
}

- (IBAction)addClassesAction:(id)sender {
    
    NSUndoManager *undoManager =  self.managedObjectContext.undoManager;
    //[undoManager beginUndoGrouping];
    Classes *classObject = [NSEntityDescription insertNewObjectForEntityForName:@"Classes" inManagedObjectContext:self.managedObjectContext];
    
    classObject.title = @"untitled";
    classObject.studentsNum = 0;
   // classObject.slogan = @"";
    
   // [undoManager endUndoGrouping];
    
    //[undoManager undo];
    
}

- (IBAction)deleteClassesAction:(id)sender {
    
    NSArray *selectedObjects = self.arrayController.selectedObjects;
    
    for( Classes *classObject in selectedObjects){
        [self.managedObjectContext deleteObject:classObject];
    }
    
}

- (IBAction)queryClassesAction:(id)sender {
    
    NSSearchField *searchField = sender;
    NSString *content = searchField.stringValue;
    
    if(!content || [content isEqualToString:@""]){
        self.arrayController.fetchPredicate = nil;
        return;
    }
    NSPredicate *predicate;
    @try {
        if(content){
          predicate = [NSPredicate predicateWithFormat:content];
        }
    }
    @catch (NSException *exception) {
        return ;
    }
    self.arrayController.fetchPredicate = predicate;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark - Core Data stack

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "macdev.io.School" in the user's Application Support directory.
    NSURL *appSupportURL = [[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"macdev.io.School"];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"School" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationDocumentsDirectory = [self applicationDocumentsDirectory];
    BOOL shouldFail = NO;
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
    // Make sure the application files directory is there
    NSDictionary *properties = [applicationDocumentsDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    if (properties) {
        if (![properties[NSURLIsDirectoryKey] boolValue]) {
            failureReason = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationDocumentsDirectory path]];
            shouldFail = YES;
        }
    } else if ([error code] == NSFileReadNoSuchFileError) {
        error = nil;
        [fileManager createDirectoryAtPath:[applicationDocumentsDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    if (!shouldFail && !error) {
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:NO], NSInferMappingModelAutomaticallyOption, nil];
        
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        NSURL *url = [applicationDocumentsDirectory URLByAppendingPathComponent:@"OSXCoreDataObjC.storedata"];
        if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:options error:&error]) {
            coordinator = nil;
        }
        _persistentStoreCoordinator = coordinator;
    }
    
    if (shouldFail || error) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        if (error) {
            dict[NSUnderlyingErrorKey] = error;
        }
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];

    return _managedObjectContext;
}




#pragma mark - Core Data Saving and Undo support

- (IBAction)saveAction:(id)sender {
    // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    NSError *error = nil;
    if ([[self managedObjectContext] hasChanges] && ![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
    return [[self managedObjectContext] undoManager];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    // Save changes in the application's managed object context before the application terminates.
    
    if (!_managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {

        // Customize this code block to include application-specific recovery steps.              
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }

        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertFirstButtonReturn) {
            return NSTerminateCancel;
        }
    }

    return NSTerminateNow;
}

@end
