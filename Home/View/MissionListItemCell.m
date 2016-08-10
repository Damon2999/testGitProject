//
//  MissionListItemCell.m
//  HelloSunshine
//
//  Created by damon on 16/7/13.
//  Copyright © 2016年 sliu. All rights reserved.
//

#import "MissionListItemCell.h"

@implementation MissionListItemCell{
    UIImageView *image;
    UILabel *title;
    UILabel *shortDis;
    UILabel *aword;

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        image  = [[UIImageView alloc] initWithImage:YGIMAGE(@"em_chat_video_pressed")];
        image.contentMode = UIViewContentModeScaleAspectFit;
        title      = [AppTool label:@"分享哎哟阳光APP给好友" textColor:color_text_main font:16 lines:0];
        shortDis   = [AppTool label:@"邀请好友一起加入阳光圈，获得商品奖励" textColor:HEXCOLOR(0x777777) font:14 lines:0];
        aword      = [AppTool label:@"100阳光币" textColor:color_text_main font:12 lines:0];
        [AppTool addSubViews:@[image,title,shortDis,aword] to:self];
        
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.centerY.equalTo(self);
            make.width.equalTo(@80);
        
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
        
        [shortDis mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(title);
            make.top.equalTo(title.mas_bottom).offset(10);
        }];
        [aword mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shortDis.mas_bottom).offset(15);
            make.right.equalTo(shortDis);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
        }];
        
        
        

        
        
    }
    
    return self;

}

@end
