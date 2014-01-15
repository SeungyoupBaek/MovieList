//
//  MovieCenter.m
//  MovieList
//
//  Created by T on 2014. 1. 14..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "MovieCenter.h"
#import <sqlite3.h>

@implementation MovieCenter{
    NSMutableArray *_actors;
    NSMutableArray *_movies;
    sqlite3 *db;
}

static MovieCenter *_instance = nil;
// DB 연결은 어디서 하나요?

+ (id)sharedMovieCenter
{
    if (nil == _instance) {
        _instance = [[MovieCenter alloc] init];
        [_instance openDB];
    }
    return _instance;
}
	
// DB 작업 모두 여기서 한다
- (BOOL)openDB{
    // 데이터베이스 오픈, 없으면 새로 만든다.
    
    // 데이터베이스 파일 경로 구하기
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dbFilePath = [docPath stringByAppendingPathComponent:@"db.sqlite"];
    
    
    // 데이터 베이스 파일 체크
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL existFile = [fm fileExistsAtPath:dbFilePath];
    
    // 데이터 베이스 오픈
    int ret = sqlite3_open([dbFilePath UTF8String], &db);
    
    if (ret != SQLITE_OK) {
        return NO;
    }
    //docPath	NSPathStore2 *	@"/Users/SDT-1/Library/Application Support/iPhone Simulator/7.0-64/Applications/8A48728B-7F2C-4A74-937E-6B9C568C4A95/Library/Documentation"	0x000000010901b720
    // 새로게 데이터베이스를 만들었으면 테이블을 생성한다.
    if (NO == existFile) {
        // 테이블 생성
        const char *createSQL = "CREAT TABLE IF NOT EXISTS MOVIE (TITLE TEXT)";
        char *errMsg;
        ret = sqlite3_exec(db, createSQL, NULL, NULL, &errMsg);
        if (ret != SQLITE_OK) {
            [fm removeItemAtPath:dbFilePath error:nil];
            NSLog(@"creating table with ret : %d", ret);
            return NO;
        }
    }
    NSLog(@"Success");
    return YES;

}
- (NSInteger)addMovieWithName:(NSString *)name{
    
    // 새로운 데이터를 데이터베이스에 저장한다.
    
    NSLog(@"adding data : %@", name);
    
    // sqlite3_exec로 실행하기
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO MOVIE (TITLE) VALUES ('%@')", name];
    NSLog(@"sql : %@", sql);
    
    char *errMsg;
    int ret1 = sqlite3_exec(db, [sql UTF8String], NULL, nil, &errMsg);
    
    if(SQLITE_OK != ret1){
        NSLog(@"Error on Insert New Data : %s", errMsg);
    }
    NSInteger movieID = (NSInteger)sqlite3_last_insert_rowid(db);
    return movieID;
}


- (NSInteger)getNumberOfMovies {
    
    
    return _movies.count;
}

- (NSString *)getNameOfMovieAtId:(NSInteger)rowID {

    // 데이터 베이스에서 사용할 쿼리 준비
    NSString* queryStr = @"SELECT rowid, title FROM MOVIE";
    sqlite3_stmt *stmt;
    int ret = sqlite3_prepare_v2(db, [queryStr UTF8String], -1, &stmt, NULL);
    
    NSAssert2(SQLITE_OK == ret, @"Error(%d) on resolving data : %s", ret, sqlite3_errmsg(db));
    NSString *titleString;
    // 모든 행의 정보를 얻어온다.
    while (SQLITE_ROW == sqlite3_step(stmt)) {
        char* title = (char *)sqlite3_column_text(stmt, 1);
        titleString = [NSString stringWithCString:title encoding:NSUTF8StringEncoding];
        }
    
    sqlite3_finalize(stmt);

    return titleString;
}

- (NSInteger)getNumberOfActorsInMovie:(NSInteger)movieIndex {
    return 3;
}

- (NSString *)getNameOfActorAtIndex:(NSInteger)index inMovie:(NSInteger)movieIndex {
    return @"스칼렛요한슨";
}

- (void)addActorWithName:(NSString *)name inMovie:(NSInteger)movieIndex {
    
}

@end
