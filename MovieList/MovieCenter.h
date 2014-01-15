//
//  MovieCenter.h
//  MovieList
//
//  Created by T on 2014. 1. 14..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieCenter : NSObject

- (BOOL)openDB;
- (NSInteger)addMovieWithName:(NSString *)name;
- (NSInteger)getNumberOfMovies;
- (NSString *)getNameOfMovieAtId:(NSInteger)rowID;
- (NSInteger)getNumberOfActorsInMovie:(NSInteger)movieIndex;
- (NSString *)getNameOfActorAtIndex:(NSInteger)index inMovie:(NSInteger)movieIndex;
- (void)addActorWithName:(NSString *)name inMovie:(NSInteger)movieIndex; 
+ (id)sharedMovieCenter;

@end
