//
//  ChatTableViewController.m
//  ChatRobot
//
//  Created by Jet on 16/6/20.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "ChatTableViewController.h"
#import "ChatTableViewCell.h"
#import "ChatModel.h"
#import "ChatFrameModel.h"

@interface ChatTableViewController ()


@property(strong,nonatomic)NSMutableArray *dataArray;
@end

@implementation ChatTableViewController
NSString *identifier =@"ChatCell";
#pragma mark-
#pragma mark-懒加载
-(NSMutableArray *)dataArray{
    
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
        
        NSString *path= [[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil];
        NSArray *dataTemp=[NSArray arrayWithContentsOfFile:path];
        
        for (NSDictionary *dict in dataTemp) {
            
           ChatModel  *chatModel=[ChatModel chatModelWithDict:dict];
            
 //           ChatFrameModel *lastChatFrameModel=_dataArray.lastObject;
//            if ([qqModel.time isEqualToString:lastQqFrameModel.qqModel.time]) {
//                
//                qqModel.hidenTimeLabel=YES;
//            }
            
            //赋值给frameModel进行frame计算
            ChatFrameModel *chatFrameModel=[[ChatFrameModel alloc]init];
            
            chatFrameModel.chatModel=chatModel;
            
            [_dataArray addObject:chatFrameModel];
        }
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerClass:[ChatTableViewCell class] forCellReuseIdentifier:identifier];
    //隐藏cell的边线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //默认滚动到最底行
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier: identifier forIndexPath:indexPath];
    if (nil==cell) {
        
        cell=[[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    ChatFrameModel *chatFrameModel=_dataArray[indexPath.row];
    
    cell.chatFrameModel=chatFrameModel;
    //选中后不改变颜色
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    return cell;

}

#pragma mark-
#pragma mark-返回每一行cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatFrameModel *chatFrameModel=self.dataArray[indexPath.row];
    return chatFrameModel.cellHeight;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
