//
//  ChatTableViewController.m
//  ChatRobot
//
//  Created by Jet on 16/6/20.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTableViewCell.h"
#import "ChatModel.h"
#import "ChatFrameModel.h"
#import "CloudData.h"
#import "NetWorkTool.h"
#import <SafariServices/SafariServices.h>


@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,SFSafariViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomLayout;

@property(strong,nonatomic)NSMutableArray *dataArray;

@property(strong,nonatomic)NSMutableArray *dataCloud;
//@property(nonatomic,strong) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation ChatViewController
NSString *identifier =@"ChatCell";



#pragma mark-
#pragma mark-懒加载
-(NSMutableArray *)dataArray{
    
    if (_dataArray==nil) {
        
        _dataArray=[NSMutableArray array];
        
        [CloudData getDataFormCloud:^(NSArray *arry) {
            NSArray *dataTemp = arry;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                for (int i= (dataTemp.count-1); i>=0; i--) {
                    AVObject *obj = dataTemp[i];
                    ChatModel *chatModel=[[ChatModel alloc]initWithObj:obj];
                    chatModel.dateTimes = obj[@"createdAt"];
                    //赋值给frameModel进行frame计算
                    ChatFrameModel *chatFrameModel=[[ChatFrameModel alloc]init];

                    chatFrameModel.chatModel=chatModel;
                    
                    [_dataArray addObject:chatFrameModel];
                    [_spinner stopAnimating];
                }
                [self.tableView reloadData];
                //默认滚动到最底行
                [self scrollToBottom];
            });
        }];
    
     }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //菊花交互

    _spinner.hidesWhenStopped = true;
    _spinner.color = [UIColor orangeColor];
    _spinner.center = self.view.center;
    [self.view addSubview:_spinner];
    [_spinner startAnimating];
    
    [self dataArray];
    [self setupUI];

    [self registerNotification];
    self.textField.delegate =self;
    //默认滚动到最底行
    [self scrollToBottom];
}


#pragma mark-
#pragma mark-内部控制方法
-(void)setupUI{
   
    //1.创建子控件
    
    //注册cell
    [self.tableView registerClass:[ChatTableViewCell class] forCellReuseIdentifier:identifier];
    //隐藏cell的边线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    
}
#pragma mark-
#pragma mark-滚动到最底行
-(void)scrollToBottom{
    if (self.dataArray.count!=0) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:true];
    }
}

-(void)registerNotification{
    //键盘即将弹出的时候监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //键盘即将隐藏的时候监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillDisAppear:) name:UIKeyboardWillHideNotification
                                               object:nil];
   //监听SFSafariViewController的使用
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(safariOpenUrl:) name:@"SafariOpenUrl"  object:nil];
}

#pragma mark-
#pragma mark-SFSafariViewController的调用
-(void)safariOpenUrl:(NSNotification*)noti{
    
        SFSafariViewController *sfViewControllr = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:noti.userInfo[@"urlBtn"]]];
        sfViewControllr.delegate = self;
    [self presentViewController:sfViewControllr animated:YES completion:nil];
}

- (void)safariViewControllerDidFinish:(nonnull SFSafariViewController *)controller{
     [controller dismissViewControllerAnimated:YES completion:nil];
}

///  监听响应事件，键盘弹出的时候调用
-(void)keyboardWillAppear:(NSNotification*)noti{
   
    NSDictionary *dict=noti.userInfo;
    //时间间隔
    NSTimeInterval interval=[dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘弹出时的Y值
    CGRect keyboardRect=[dict[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat keyboardBegingY=keyboardRect.origin.y;
    NSLog(@"%f",keyboardBegingY);
    //键盘弹出后的Y值
    CGRect tempRect=[dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardEndY=tempRect.origin.y;
    NSLog(@"%f",keyboardEndY);
    
    if (ABS(keyboardBegingY-keyboardEndY)<10) {
        return;
    }
   [UIView animateWithDuration:interval animations:^{
       self.view.transform=CGAffineTransformMakeTranslation(0, keyboardEndY-keyboardBegingY);
   } completion:^(BOOL finished) {
       [self scrollToBottom];
   }];
    
}

-(void)keyboardWillDisAppear:(NSNotification*)noti{
    
    NSDictionary *dict=noti.userInfo;
    
    NSTimeInterval interval=[dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:interval animations:^{
        self.view.transform =CGAffineTransformIdentity;
    }];
}



#pragma mark-
#pragma mark-移除监听
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (IBAction)sendBtn {
    
    [self sendMessage];
}

-(BOOL)sendMessage{

    
    
    if (self.textField.text.length==0) {
        return YES;
    }
    //自己发送消息
    [self sendMessageWith:self.textField.text andType:ChatUserTypeMe andUrl:nil];
    
    //别人发送消息
    //向图灵发送请求
    [NetWorkTool post:self.textField.text andFinish:^(NSDictionary *dict, NSError *error) {
        if (error != nil) {
            NSLog(@"%@",error.localizedDescription);
            
             [self sendMessageWith:@"没听明白，再说一次吧！" andType:ChatUserTypeOther andUrl:nil];
        }else{
            NSString *url = [[NSString alloc]init];
            //链接类/列车类/航班类
            if (dict[@"url"] != nil) {
                url = dict[@"url"];
            }
            //新闻类/菜谱类
            if (dict[@"list"] != nil) {
                
                if (dict[@"list"][0][@"detailurl"] != nil) {
                    url = dict[@"list"][0][@"detailurl"];
                }
            }
            
            [self sendMessageWith:dict[@"text"] andType:ChatUserTypeOther andUrl:url];
        }
    }];
    
    //清空textField.text
    self.textField.text=@"";
    return YES;
}
#pragma mark-
#pragma mark- textField的代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return [self sendMessage];
}

#pragma mark-
#pragma mark-发送消息
-(void)sendMessageWith:(NSString *)message andType:(ChatUserType)type andUrl:(NSString*)url{
    
    //添加一条数据
    ChatModel *chatModel=[[ChatModel alloc]init];

    NSDate *date=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"HH:mm";
//
    NSString *dateTime= [formatter stringFromDate:date];

    chatModel.dateTimes = date;
    chatModel.time=dateTime;
    chatModel.text=message;
    chatModel.type=type;
 
    if (url.length != 0) {
        chatModel.url=url;
        chatModel.text= [NSString stringWithFormat:@"%@%@",message,@"(点击该消息打开查看)"];
    }

    ChatFrameModel *cfm=_dataArray.lastObject;
    if([cfm.chatModel.time isEqualToString:chatModel.time]==true){
       
        chatModel.hidenTimeLabel = true;
    }
    
    ChatFrameModel *chatFrameModel=[[ChatFrameModel alloc]init];
    chatFrameModel.chatModel=chatModel;
    
    [_dataArray addObject:chatFrameModel];
    
    
    //插入一条数据
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
    [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    //滚动到最后一行的方法
    [self scrollToBottom];
    //保存数据到云端
    [CloudData saveDataToCloud:chatModel];
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
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [textFiled resignFirstResponder];
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//隐藏键盘
    [self.textField resignFirstResponder];
}
#pragma mark-
#pragma mark-返回每一行cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChatFrameModel *chatFrameModel=self.dataArray[indexPath.row];
    return chatFrameModel.cellHeight;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
