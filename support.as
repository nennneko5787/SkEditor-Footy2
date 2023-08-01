;(support.as)
#ifdef __hsp30__
#ifndef __EXSUPPORT__
#define  __EXSUPPORT__
	#module "statusmod"
	#uselib "comctl32.dll"
	#func global InitCommonControlsEx "InitCommonControlsEx" sptr
	#cfunc global CreateStatusWindow "CreateStatusWindow" int,sptr,int,int
	#uselib "kernel32.dll"
	#func global GetModuleFileName "GetModuleFileNameA" int,sptr,int
	#uselib "shell32.dll"
	#func global ExtractIconEx "ExtractIconExA" sptr,int,sptr,sptr,int
	#uselib  "user32.dll"
	#func global InvalidateRect "InvalidateRect" int,int,int

	#define global SB_SETPARTS		$00000404
	#define global SB_SETICON		$0000040F
	#define global SB_SETTEXT		$00000401
	#define global SB_SETBKCOLOR	$00002001
	#define global SB_SIMPLE		$00000409
	#define global SB_SIMPLEID		$000000FF

	#defcfunc Createstsbar int prm1
	;*******************************************************************************
	;   ステータスバーを作成 (Createstsbar)
	;
	;   戻り値 : 成功 stshwnd=ステータスバーハンドル, 失敗 stshwnd=<0
	;
	;   ・書式     ret = Createstsbar(option)
	;   ・引数     option (int) : $100 Size Grip付きoption
	;   ・タイプ   ユーザー定義関数
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   stshwnd=Createstsbar($100)
	;*******************************************************************************
	style = prm1    ;mode option($100) Size Grip付き
	if style=$100 : style += $50000803 : else : style = $50000803
	InitCommonControlsEx icx
	stshwnd=CreateStatusWindow(style,String,hwnd,0)
	InvalidateRect stshwnd,0,1
	return stshwnd

	#deffunc StsIcon int prm1,int prm2
	;*******************************************************************************
	;   ステータスバーの任意セルにリソースアイコンを追加 (StsIcon)
	;
	;   戻り値 : 成功 stat=0, 失敗 stat=-1
	;
	;   ・書式     StsIcon stshwnd,Index
	;   ・引数     stshwnd (int) : Createstsbarで作成したハンドル (stshwnd)
	;              Index   (int) : 0～(0) セルのインデックス
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   StsIcon stshwnd,0
	;*******************************************************************************
	stshwnd = prm1 : if stshwnd==0 : return -1
	Index   = prm2 : if Index<=0   : Index =0     ;(* Index=Cell Index *)

	;自分自身のファイル名を取得
	sdim lpFileName,260
	GetModuleFileName hModule,lpFileName,260
	SelfName=lpFileName

	icobig=0
	ExtractIconEx SelfName,0,icobig,icosmall,1
	hIcon=icosmall

	;SB_SETICON メッセージを送信
	sendmsg stshwnd,SB_SETICON,Index,hIcon
	sdim lpFileName,0
	return stat

	#deffunc Stscell int prm1,array prm2,int prm3
	;*******************************************************************************
	;   ステータスバーにセルを設定 (Stscell)
	;
	;   戻り値 : 成功 stat=1, 失敗 stat=-1
	;
	;   ・書式     Stscell stshwnd,cellwidth,cell_num
	;   ・引数     stshwnd   (int)   : Createstsbarで作成したハンドル (stshwnd)
	;              cellwidth (array) : セルの幅
	;              cell_num  (int)   : 0～(0) セルの個数
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   c=ginfo_winx-460,-1
	;   Stscell stshwnd,c,2
	;*******************************************************************************
	stshwnd  = prm1 : if stshwnd==0  : return -1
	cell_num = prm3 : if cell_num<=0 : cell_num=0

	;SB_SETPARTS メッセージを送信
	sendmsg stshwnd,SB_SETPARTS, cell_num, varptr(prm2)
	return stat

	#deffunc Stsinf int prm1,str prm2,int prm3
	;*******************************************************************************
	;   ステータスバーに文字列を設定 (Stsinf)
	;
	;   戻り値 : 成功 stat=1, 失敗 stat=-1
	;
	;   ・書式     Stsinf stshwnd,String,Index
	;   ・引数     stshwnd (int) : Createstsbarで作成したハンドル (stshwnd)
	;              String  (str) : 設定文字列 or 文字列型変数
	;              Index   (int) : 0～(0) セルのインデックス
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   Stsinf stshwnd," HSP Script Programing 2005",0
	;*******************************************************************************
	stshwnd = prm1 : if stshwnd==0 : return -1
	String  = prm2 : if strlen(String)=0 : String=""
	Index   = prm3 : if Index<=0   : Index=0

	;SB_SETTEXT メッセージを送信
	sendmsg stshwnd,SB_SETTEXT,Index,varptr(String)
	return stat

	#deffunc StsColor int prm1
	;*******************************************************************************
	;   ステータスバーの背景色を設定 (StsColor)
	;
	;   戻り値 : 成功 stat=0, 失敗 stat=-1
	;
	;   ・書式     StsColor stshwnd
	;   ・引数     stshwnd (int) : Createstsbarで作成したハンドル (stshwnd)
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   color 0,0,200 : StsColor stshwnd
	;*******************************************************************************
	mref bmscr,67
	stshwnd = prm1 : if stshwnd==0 : return -1

	;●設定する色は、color命令で指定する

	;SB_SETBKCOLOR メッセージを送信
	sendmsg stshwnd,SB_SETBKCOLOR,0,bmscr(40)
	return 0

	#deffunc StsRsetsimple int prm1
	;*******************************************************************************
	;   シンプルモードの解除 (StsRsetsimple)
	;
	;   戻り値 : 成功 stat=1, 失敗 stat=-1
	;
	;   ・書式     StsRsetsimple stshwnd
	;   ・引数     stshwnd (int) : Createstsbarで作成したハンドル (stshwnd)
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   StsRsetsimple stshwnd
	;*******************************************************************************
	stshwnd = prm1 : if stshwnd==0 : return -1

	;SB_SIMPLE メッセージを送信
	sendmsg stshwnd,SB_SIMPLE,0,0
	return stat

	#deffunc StsSetsimple int prm1,str prm2
	;*******************************************************************************
	;   シンプルモードの設定 (StsSetsimple)
	;
	;   戻り値 : 成功 stat=1, 失敗 stat=-1
	;
	;   ・書式     StsSetsimple stshwnd,String
	;   ・引数     stshwnd (int) : Createstsbarで作成したハンドル (stshwnd)
	;              String  (str) : 設定文字列 or 文字列型変数
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   StsSetsimple stshwnd," HSP Script Programing 2005"
	;*******************************************************************************
	stshwnd = prm1 : if stshwnd==0 : return -1
	String  = prm2

	;SB_SIMPLE メッセージを送信
	sendmsg stshwnd,SB_SIMPLE,1,0

	;SB_SETTEXT メッセージを送信
	sendmsg stshwnd,SB_SETTEXT, SB_SIMPLEID,varptr(String)
	return stat
	#global

	#define global MF_APPEND		$00000100
	#define global MF_BYCOMMAND		$00000000
	#define global MF_BYPOSITION	$00000400
	#define global MF_CHANGE		$00000080
	#define global MF_CHECKED		$00000008
	#define global MF_DELETE		$00000200
	#define global MF_DISABLED		$00000002
	#define global MF_ENABLED		$00000000
	#define global MF_GRAYED		$00000001
	#define global MF_INSERT		$00000000
	#define global MF_POPUP			$00000010
	#define global MF_REMOVE		$00001000
	#define global MF_SEPARATOR		$00000800
	#define global MF_STRING		$00000000
	#define global MF_UNCHECKED		$00000000
	#define global TPM_RETURNCMD	$00000100

	#module "menumod"
	#uselib "user32.dll"
	#func global DestroyMenu "DestroyMenu" int
	#func global CreatePopupMenu "CreatePopupMenu"
	#func global SetMenu "SetMenu" int,int
	#func global CreateMenu "CreateMenu"
	#func global GetMenu "GetMenu" int,int
	#func global DrawMenuBar "DrawMenuBar" int,int
	#func global AppendMenu "AppendMenuA" int,int,int,sptr
	#func global InsertMenu "InsertMenuA" int,int,int,int,sptr
	#func global ModifyMenu "ModifyMenuA" int,int,int,int,sptr
	#func global RemoveMenu "RemoveMenu" int,int,int
	#func global CheckMenuItem "CheckMenuItem" int,int,int
	#func global EnableMenuItem "EnableMenuItem" int,int,int
	#func global GetMenuState "GetMenuState" int,int,int,int,int
	#func global GetMenuString "GetMenuStringA" int,int,sptr,int,int
	#func global TrackPopupMenu "TrackPopupMenu" int,int,int,int,int,int,int

	#define global MAX_MENU			$0100

	#deffunc InitMenu
	;*******************************************************************************
	;   メニュー作成初期化 (自動実行) (InitMenu)
	;
	;   ・書式     InitMenu
	;   ・引数     なし
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   なし（自動実行）
	;*******************************************************************************
	dim hMenu,MAX_MENU : cMenu=0 : init=1
	return

	#defcfunc Create_Menu int prm1
	;*******************************************************************************
	;   メニューを作成 (Create_Menu)
	;
	;   戻り値 : 成功 hmenu=メニューのハンドル, 失敗 hmenu<=0の値
	;
	;   ・書式     hmenu = Create_Menu(menu_ID)
	;   ・引数     menu_ID (int) : 0～MAX_MENU メニューID
	;   ・タイプ   ユーザー定義関数
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   hmenu=Create_Menu(0)  ;Menu bar
	;   hmenu=Create_Menu(1)  ;Popup Menu
	;*******************************************************************************
	MenuID=prm1

	;▼note : ID=0 ... Window用 Menu bar それ以外 Popup Menu
	if init==0 : InitMenu
	if (MenuID<0)||(MenuID>=MAX_MENU) : return 0
	if MenuID{
		;▼Popup Menu
		if hMenu(MenuID) : DestroyMenu hMenu(MenuID)
		CreatePopupMenu : hMenu(MenuID)=stat
		ret=stat
	}else{
		;▼Window Menu
		SetMenu hwnd,0
		if hMenu(MenuID) : DestroyMenu hMenu(MenuID)
		CreateMenu : hMenu(MenuID)=stat
		ret=stat
	}
	cMenu=MenuID
	return ret

	#deffunc SetMenumode int prm1
	;*******************************************************************************
	;   メニュー項目動作モード設定 (SetMenumode)
	;
	;   戻り値 : stat=メニューハンドル 
	;
	;   ・書式     SetMenumode Mode
	;   ・引数     Mode (int) : 0 or 0以外 表示 or 非表示のモード
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   SetMenumode 1
	;*******************************************************************************
	Mode=prm1

	;▼モード = 0以外のとき、ID0のメニューをウィンドウに表示
	;▼モード = 0 非表示
	if init==0 : InitMenu
	if Mode{
		GetMenu hwnd,1 : oldMenu=stat
		if oldMenu!=hMenu(0) {
			SetMenu hwnd,hMenu(0) : ret=stat
			if oldMenu : DestroyMenu oldMenu
		}
		DrawMenuBar hwnd,1
	}else{
		SetMenu hwnd,0 : ret=stat
	}
	return ret

	#deffunc SelectMenu int prm1
	;*******************************************************************************
	;   メニュー項目操作先を選択 (SelectMenu)
	;
	;   戻り値 : 成功 stat=0, 失敗 stat=-1
	;
	;   ・書式     SelectMenu menu_ID
	;   ・引数     menu_ID (int) : 0～MAX_MENU 項目操作先メニューID
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   SelectMenu 1
	;*******************************************************************************
	MenuID=prm1

	if init==0 : InitMenu
	if (MenuID<0)||(MenuID>=MAX_MENU) : return -1
	cMenu=MenuID
	return 0

	#deffunc Append_Menu str prm1,int prm2,int prm3
	;*******************************************************************************
	;   メニュー項目を追加 (Append_Menu)
	;
	;   戻り値 : 成功 stat=0, 失敗 stat=-1
	;
	;   ・書式     Append_Menu String,ItemID,Flags
	;   ・引数     String (str) : 追加項目名文字列 or 文字列型変数
	;              ItemID (int) : 項目ID
	;              Flags  (int) : 0～(0) フラグ(MF_POPUP,MF_GRAYED,MF_CHECKED)
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   Append_Menu "menu01-1 (Sub Menu)",1100
	;   Append_Menu "menu01-2 (Sub Menu)",1200
	;*******************************************************************************
	String=prm1 : if strlen(String)==0 : String=""
	ItemID=prm2 : if ItemID<0 : return -1
	Flags =prm3 : if Flags<=0 : Flags=0

	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if Flags&MF_POPUP : ItemID=hMenu(ItemID)
	AppendMenu hMenu(cMenu),Flags,ItemID,String
	return 0

	#deffunc Insert_Menu int prm1,str prm2,int prm3,int prm4,int prm5
	;*******************************************************************************
	;   メニュー項目を挿入 (Insert_Menu)
	;
	;   戻り値 : stat=メニューハンドル, 失敗 stat=-1
	;
	;   ・書式     Insert_Menu Position,String,ItemID,Flags,Mode
	;   ・引数     Position (int) : 0～(0) 挿入位置
	;              String   (str) : 挿入項目名文字列 or 文字列型変数
	;              ItemID   (int) : 項目ID
	;              Flags    (int) : 0～(0) フラグ(MF_SEPARATOR,MF_POPUP,MF_GRAYED,MF_CHECKED)
	;              Mode     (int) : 位置モード (0=MF_BYCOMMAND or 1=MF_BYPOSITION)
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   Insert_Menu 1,"",0,MF_SEPARATOR   ;セパレータを挿入
	;*******************************************************************************
	Position=prm1 : if Position<=0: Position=0
	String  =prm2 : if strlen(String)==0 : String=""
	ItemID  =prm3 : if ItemID<0   : return -1
	Flags   =prm4 : if Flags<=0   : Flags=0
	Mode    =prm5 : if Mode<=0    : Mode=0

	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if Flags&MF_POPUP : ItemID=hMenu(ItemID)
	if Mode : opt=MF_BYCOMMAND : else : opt=MF_BYPOSITION
	InsertMenu hMenu(cMenu),Position,Flags|opt,ItemID,String
	return stat

	#deffunc Modify_Menu int prm1,str prm2,int prm3,int prm4,int prm5
	;*******************************************************************************
	;   メニュー項目を変更 (Modify_Menu)
	;
	;   戻り値 : stat=メニューハンドル, 失敗 stat=-1
	;
	;   ・書式     Modify_Menu Position,String,ItemID,Flags,Mode
	;   ・引数     Position (int) : 0～(0) 挿入位置
	;              String   (str) : 変更項目名文字列 or 文字列型変数
	;              ItemID   (int) : 項目ID
	;              Flags    (int) : 0～(0) フラグ(MF_SEPARATOR,MF_POPUP,MF_GRAYED,MF_CHECKED)
	;              Mode     (int) : 位置モード (0=MF_BYCOMMAND or 1=MF_BYPOSITION)
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   Modify_Menu 0,"サンプル",1,MF_GRAYED
	;*******************************************************************************
	Position=prm1 : if Position<=0 : Position=0
	String  =prm2 : if strlen(String)==0 : String=""
	ItemID  =prm3 : if ItemID<=0   : ItemID=0
	Flags   =prm4 : if Flags<=0    : Flags=0
	Mode    =prm5 : if Mode<=0     : Mode=0

	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if Flags&MF_POPUP : ItemID=hMenu(ItemID)
	if Mode : opt=MF_BYCOMMAND : else : opt=MF_BYPOSITION
	ModifyMenu hMenu(cMenu),Position,Flags|opt,ItemID,String
	return stat

	#deffunc Remove_Menu int prm1,int prm2
	;*******************************************************************************
	;   メニュー項目を削除 (Remove_Menu)
	;
	;   戻り値 : stat=メニューハンドル, 失敗 stat=-1
	;
	;   ・書式     Remove_Menu Position,Mode
	;   ・引数     Position (int) : 0～(0) 挿入位置
	;              Mode     (int) : 位置モード (0=MF_BYCOMMAND or 1=MF_BYPOSITION)
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   Remove_Menu 4,0
	;*******************************************************************************
	Position=prm1 : if Position<=0 : Position=0
	Mode    =prm2 : if Mode<=0     : Mode=0

	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if Mode : opt=MF_BYCOMMAND : else : opt=MF_BYPOSITION
	RemoveMenu hMenu(cMenu),Position,opt
	return stat

	#deffunc CheckMenu_Item int prm1,int prm2,int prm3
	;*******************************************************************************
	;   項目のチェックマークを表示・非表示設定 (CheckMenu_Item)
	;
	;   戻り値 : stat=チエック状態, 失敗 stat=-1
	;
	;   ・書式     CheckMenu_Item Position,Flags,Mode
	;   ・引数     Position (int) : 0～(0) チェックマーク位置
	;              Flags    (int) : 0～(0) フラグ(MF_CHECKED,MF_UNCHECKED)
	;              Mode     (int) : 位置モード (0=MF_BYCOMMAND or 1=MF_BYPOSITION)
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   CheckMenu_Item 1,MF_CHECKED,0
	;*******************************************************************************
	Position=prm1 : if Position<=0 : Position=0
	Flags   =prm2 : if Flags<=0    : Flags=0
	Mode    =prm3 : if Mode<=0     : Mode=0

	;▼ステータスは、MF_CHECKEDかMF_UNCHECKED
	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if Mode  : opt=MF_BYCOMMAND : else : opt=MF_BYPOSITION
	if Flags : Flags=MF_CHECKED : else : Flags=MF_UNCHECKED
	CheckMenuItem hMenu(cMenu),Position,Flags|opt
	ret=stat/MF_CHECKED
	return ret

	#deffunc EnableMenu_Item int prm1,int prm2,int prm3
	;*******************************************************************************
	;   項目の選択可能状態を変更 (EnableMenu_Item)
	;
	;   戻り値 : stat=選択状態, 失敗 stat=-1
	;
	;   ・書式     EnableMenu_Item Position,Flags,Mode
	;   ・引数     Position (int) : 0～(0) チェックマーク位置
	;              Flags    (int) : 0～(0) フラグ(MF_ENABLED,MF_DISABLED,MF_GRAYED)
	;              Mode     (int) : 位置モード (0=MF_BYCOMMAND or 1=MF_BYPOSITION)
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   EnableMenu_Item 5,MF_ENABLED,0
	;*******************************************************************************
	Position=prm1 : if Position<=0 : Position=0
	Flags   =prm2 : if Flags<=0    : Flags=0
	Mode    =prm3 : if Mode<=0     : Mode=0

	;▼ステータスは、MF_ENABLED, MF_DISABLED, MF_GRAYED
	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if Mode : opt=MF_BYCOMMAND : else : opt=MF_BYPOSITION
	EnableMenuItem hMenu(cMenu),Position,Flags|opt
	return stat

	#deffunc GetMenu_State int prm1,int prm2
	;*******************************************************************************
	;   メニュー項目の状態を取得 (GetMenu_State)
	;
	;   戻り値 : stat=項目のステータス, 失敗 stat=-1, refstr=表示中の文字列
	;
	;   ・書式     GetMenu_State Position,Mode
	;   ・引数     Position (int) : 0～(0) 項目位置
	;              Mode     (int) : 位置モード (0=MF_BYCOMMAND or 1=MF_BYPOSITION)
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   GetMenu_State 4,0 : Item=stat
	;*******************************************************************************
	mref ref,65
	Position=prm1 : if Position<=0 : Position=0
	Mode    =prm2 : if Mode<=0     : Mode=0

	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if Mode : opt=MF_BYCOMMAND : else : opt=MF_BYPOSITION
	sdim String,256 : String=""
	GetMenuString hMenu(cMenu),Position,String,256,opt
	GetMenuState hMenu(cMenu),Position,opt
	ref=String
	return stat

	#deffunc TrackPopup_Menu int prm1,int prm2,int prm3
	;*******************************************************************************
	;   メニュー項目の状態を取得(右クリックメニュー用) (TrackPopup_Menu)
	;
	;   戻り値 : stat=メニューが選択されたら選択された項目ID(CommandID), 失敗 stat=-1
	;
	;   ・書式     TrackPopup_Menu x,y,Flags
	;   ・引数     x     (int) : mouse x (通常は-1を指定する)
	;              y     (int) : mouse y (通常は-1を指定する)
	;              Flags (int) : 0
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   TrackPopup_Menu -1,-1
	;   itemID=stat
	;*******************************************************************************
	x    =prm1        ;(Screen座標系)
	y    =prm2        ;(Screen座標系)
	Flags=prm3

	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if x<0 : x=ginfo(0)  ;prmx (HSP Ver2.x)
	if y<0 : y=ginfo(1)  ;prmy (HSP Ver2.x)
	TrackPopupMenu hMenu(cMenu),Flags|TPM_RETURNCMD,x,y,0,hwnd,0
	return stat

	#defcfunc GetmenuHandle
	;*******************************************************************************
	;   メニューハンドルを取得 (GetmenuHandle)
	;
	;   戻り値 : ret=選択中のメニューハンドル
	;
	;   ・書式     ret=GetHandle()
	;   ・引数     なし
	;   ・タイプ   ユーザー定義関数
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   selMenuhwnd=GetmenuHandle()
	;*******************************************************************************
	if init==0 : InitMenu
	return hMenu(cMenu)

	#deffunc Destroy_Menu
	;*******************************************************************************
	;   メニューを削除 (Destroy_Menu)
	;
	;   ・書式     Destroy_Menu
	;   ・引数     なし
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   Destroy_Menu
	;*******************************************************************************
	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if cMenu==0 : SetMenumode
	DestroyMenu hMenu(cMenu)
	return stat

	#deffunc DestroyAllMenu
	;*******************************************************************************
	;   すべてのメニューを削除 (DestroyAllMenu)
	;
	;   ・書式     DestroyAllMenu
	;   ・引数     なし
	;   ・タイプ   モジュール命令
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (使用例)
	;   DestroyAllMenu
	;*******************************************************************************
	if init==0 : return -1
	SetMenumode
	repeat MAX_MENU
		if hMenu(cnt) : DestroyMenu hMenu(cnt)
	loop
	return 0
	#global

	InitMenu   ;//初期化実行

#endif
#endif
;--------------------------------------------------------------- (EOF) ---------
