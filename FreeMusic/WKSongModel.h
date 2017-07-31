
#import <Foundation/Foundation.h>
@interface WKSongModel : NSObject

@property (nonatomic,assign) long long  queryId;
@property (nonatomic,assign) long long  song_id;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,assign) long long  artist_id;
@property (nonatomic,copy) NSString * author;//author
@property (nonatomic,assign) long long  album_id;
@property (nonatomic,copy) NSString * album_title;
@property (nonatomic,copy) NSString * pic_small;
@property (nonatomic,copy) NSString * pic_big;
@property (nonatomic,copy) NSString * songPicRadio;
@property (nonatomic,copy) NSString * lrclink;
@property (nonatomic,copy) NSString * version;
@property (nonatomic,assign) int file_duration;
@property (nonatomic,assign) int linkCode;
@property (nonatomic,copy) NSString * songLink;
@property (nonatomic,copy) NSString * showLink;
@property (nonatomic,copy) NSString * format;
@property (nonatomic,assign) int rate;
@property (nonatomic,assign) long long  size;
@property (nonatomic,assign) long long ting_uid;
@property (nonatomic,assign) int all_artist_ting_uid;
@property (nonatomic,assign) int all_artist_id;
@property (nonatomic,copy) NSString * language;
@property (nonatomic,copy) NSString * publishtime;
@property (nonatomic,assign) int album_no;
@property (nonatomic,copy) NSString *country;
@property (nonatomic,assign) int  area;
@property (nonatomic,assign) int hot;
@property (nonatomic,assign) int del_status;
@property (nonatomic,assign) int resource_type;
@property (nonatomic,assign) int copy_type;
@property (nonatomic,assign) int relate_status;
@property (nonatomic,assign) int all_rate;
@property (nonatomic,assign) int has_mv_mobile;
@property (nonatomic,assign) long long toneid;
@property (nonatomic,assign) int  is_first_publish;
@property (nonatomic,assign) int  havehigh;
@property (nonatomic,assign) int charge;
@property (nonatomic,assign) int  has_mv;
@property (nonatomic,assign) int  learn;
@property (nonatomic,assign) int  piao_id;
@property (nonatomic,assign) long long listen_total;
@property (nonatomic,assign) int isLocal;

-(NSMutableArray *)mySong;

@end

@interface WKSongList : NSObject

@property (nonatomic,assign) int songnums;
@property (nonatomic,assign) BOOL havemore;
@property (nonatomic,assign) int error_code;
@property (nonatomic,retain) NSMutableArray * songLists;

@end


/*WKMySongModel 
@property (nonatomic,assign) long long ting_uid;0
@property (nonatomic,assign) long long song_id;0
@property (nonatomic,copy) NSString * author;0
@property (nonatomic,copy) NSString * title;0
@property (nonatomic,assign)int file_duration;0
@property (nonatomic,copy) NSString * lrclink;0
@property (nonatomic,copy) NSString * songLink;0
@property (nonatomic,copy) NSString * pic_big;0
@property (nonatomic,assign) long long album_id;0
@property (nonatomic,copy) NSString * album_title;0
*/

/*
 @property (nonatomic,assign) int artist_id;0
 @property (nonatomic,assign) int all_artist_ting_uid;0
 @property (nonatomic,assign) int all_artist_id;0
 @property (nonatomic,copy) NSString * language;0
@property (nonatomic,assign) int album_no;0
 @property (nonatomic,copy) NSString * pic_small;0
 @property (nonatomic,copy) NSString *country;0
 @property (nonatomic,assign) int  area;0
 @property (nonatomic,assign) int hot;0
 @property (nonatomic,assign) int del_status;0
 @property (nonatomic,assign) int resource_type;0
 @property (nonatomic,assign) int copy_type;0
 @property (nonatomic,assign) int relate_status;0
 @property (nonatomic,assign) int all_rate;0
 @property (nonatomic,assign) int has_mv_mobile;0
 @property (nonatomic,assign) long long toneid;0
 @property (nonatomic,assign) int  is_first_publish;
 @property (nonatomic,assign) int  havehigh;0
 @property (nonatomic,assign) int charge;0
 @property (nonatomic,assign) int  has_mv;0
 @property (nonatomic,assign) int  learn;0
 @property (nonatomic,assign) int  piao_id;0
 @property (nonatomic,assign) long long listen_total;0
 */

/*
 create table WKSongListTable (song_id integer primary key,queryId integer,title text,artist_id integer,author text,album_id integer,album_title text,pic_small text,pic_big text,songPicRadio text,lrclink text,version text,file_duration integer,linkCode integer,songLink text,showLink text,format text,rate integer,size integer,ting_uid integer,all_artist_ting_uid integer,all_artist_id integer,language text,publishtime text,album_no integer,country text,area integer,hot integer,del_status integer,resource_type integer,copy_type integer,relate_status integer,all_rate integer,has_mv_mobile integer,toneid integer,is_first_publish integer,havehigh integer,charge integer,has_mv integer,learn integer,piao_id integer,listen_total integer,isLocal integer);
 */

//@property (nonatomic,assign) int file_bitrate;
//@property (nonatomic,copy) NSString * file_link;
//@property (nonatomic,copy) NSString * file_extension;
//@property (nonatomic,assign) long file_size;
//@property (nonatomic,assign) int file_duration;
//@property (nonatomic,assign) long song_file_id;
//@property (nonatomic,copy) NSString * show_link;
//@property (nonatomic,copy) NSString * hash;
//@property (nonatomic,assign) int  can_load;
//@property (nonatomic,assign) int can_see;
//@property (nonatomic,assign) int  is_udition_url;
//@property (nonatomic,assign) int  original;
//@property (nonatomic,assign) int  preload;
//@property (nonatomic,assign) int  down_type;
//@property (nonatomic,assign) float replay_gain;
