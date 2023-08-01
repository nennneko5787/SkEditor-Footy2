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
	;   �X�e�[�^�X�o�[���쐬 (Createstsbar)
	;
	;   �߂�l : ���� stshwnd=�X�e�[�^�X�o�[�n���h��, ���s stshwnd=<0
	;
	;   �E����     ret = Createstsbar(option)
	;   �E����     option (int) : $100 Size Grip�t��option
	;   �E�^�C�v   ���[�U�[��`�֐�
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   stshwnd=Createstsbar($100)
	;*******************************************************************************
	style = prm1    ;mode option($100) Size Grip�t��
	if style=$100 : style += $50000803 : else : style = $50000803
	InitCommonControlsEx icx
	stshwnd=CreateStatusWindow(style,String,hwnd,0)
	InvalidateRect stshwnd,0,1
	return stshwnd

	#deffunc StsIcon int prm1,int prm2
	;*******************************************************************************
	;   �X�e�[�^�X�o�[�̔C�ӃZ���Ƀ��\�[�X�A�C�R����ǉ� (StsIcon)
	;
	;   �߂�l : ���� stat=0, ���s stat=-1
	;
	;   �E����     StsIcon stshwnd,Index
	;   �E����     stshwnd (int) : Createstsbar�ō쐬�����n���h�� (stshwnd)
	;              Index   (int) : 0�`(0) �Z���̃C���f�b�N�X
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   StsIcon stshwnd,0
	;*******************************************************************************
	stshwnd = prm1 : if stshwnd==0 : return -1
	Index   = prm2 : if Index<=0   : Index =0     ;(* Index=Cell Index *)

	;�������g�̃t�@�C�������擾
	sdim lpFileName,260
	GetModuleFileName hModule,lpFileName,260
	SelfName=lpFileName

	icobig=0
	ExtractIconEx SelfName,0,icobig,icosmall,1
	hIcon=icosmall

	;SB_SETICON ���b�Z�[�W�𑗐M
	sendmsg stshwnd,SB_SETICON,Index,hIcon
	sdim lpFileName,0
	return stat

	#deffunc Stscell int prm1,array prm2,int prm3
	;*******************************************************************************
	;   �X�e�[�^�X�o�[�ɃZ����ݒ� (Stscell)
	;
	;   �߂�l : ���� stat=1, ���s stat=-1
	;
	;   �E����     Stscell stshwnd,cellwidth,cell_num
	;   �E����     stshwnd   (int)   : Createstsbar�ō쐬�����n���h�� (stshwnd)
	;              cellwidth (array) : �Z���̕�
	;              cell_num  (int)   : 0�`(0) �Z���̌�
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   c=ginfo_winx-460,-1
	;   Stscell stshwnd,c,2
	;*******************************************************************************
	stshwnd  = prm1 : if stshwnd==0  : return -1
	cell_num = prm3 : if cell_num<=0 : cell_num=0

	;SB_SETPARTS ���b�Z�[�W�𑗐M
	sendmsg stshwnd,SB_SETPARTS, cell_num, varptr(prm2)
	return stat

	#deffunc Stsinf int prm1,str prm2,int prm3
	;*******************************************************************************
	;   �X�e�[�^�X�o�[�ɕ������ݒ� (Stsinf)
	;
	;   �߂�l : ���� stat=1, ���s stat=-1
	;
	;   �E����     Stsinf stshwnd,String,Index
	;   �E����     stshwnd (int) : Createstsbar�ō쐬�����n���h�� (stshwnd)
	;              String  (str) : �ݒ蕶���� or ������^�ϐ�
	;              Index   (int) : 0�`(0) �Z���̃C���f�b�N�X
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   Stsinf stshwnd," HSP Script Programing 2005",0
	;*******************************************************************************
	stshwnd = prm1 : if stshwnd==0 : return -1
	String  = prm2 : if strlen(String)=0 : String=""
	Index   = prm3 : if Index<=0   : Index=0

	;SB_SETTEXT ���b�Z�[�W�𑗐M
	sendmsg stshwnd,SB_SETTEXT,Index,varptr(String)
	return stat

	#deffunc StsColor int prm1
	;*******************************************************************************
	;   �X�e�[�^�X�o�[�̔w�i�F��ݒ� (StsColor)
	;
	;   �߂�l : ���� stat=0, ���s stat=-1
	;
	;   �E����     StsColor stshwnd
	;   �E����     stshwnd (int) : Createstsbar�ō쐬�����n���h�� (stshwnd)
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   color 0,0,200 : StsColor stshwnd
	;*******************************************************************************
	mref bmscr,67
	stshwnd = prm1 : if stshwnd==0 : return -1

	;���ݒ肷��F�́Acolor���߂Ŏw�肷��

	;SB_SETBKCOLOR ���b�Z�[�W�𑗐M
	sendmsg stshwnd,SB_SETBKCOLOR,0,bmscr(40)
	return 0

	#deffunc StsRsetsimple int prm1
	;*******************************************************************************
	;   �V���v�����[�h�̉��� (StsRsetsimple)
	;
	;   �߂�l : ���� stat=1, ���s stat=-1
	;
	;   �E����     StsRsetsimple stshwnd
	;   �E����     stshwnd (int) : Createstsbar�ō쐬�����n���h�� (stshwnd)
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   StsRsetsimple stshwnd
	;*******************************************************************************
	stshwnd = prm1 : if stshwnd==0 : return -1

	;SB_SIMPLE ���b�Z�[�W�𑗐M
	sendmsg stshwnd,SB_SIMPLE,0,0
	return stat

	#deffunc StsSetsimple int prm1,str prm2
	;*******************************************************************************
	;   �V���v�����[�h�̐ݒ� (StsSetsimple)
	;
	;   �߂�l : ���� stat=1, ���s stat=-1
	;
	;   �E����     StsSetsimple stshwnd,String
	;   �E����     stshwnd (int) : Createstsbar�ō쐬�����n���h�� (stshwnd)
	;              String  (str) : �ݒ蕶���� or ������^�ϐ�
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   StsSetsimple stshwnd," HSP Script Programing 2005"
	;*******************************************************************************
	stshwnd = prm1 : if stshwnd==0 : return -1
	String  = prm2

	;SB_SIMPLE ���b�Z�[�W�𑗐M
	sendmsg stshwnd,SB_SIMPLE,1,0

	;SB_SETTEXT ���b�Z�[�W�𑗐M
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
	;   ���j���[�쐬������ (�������s) (InitMenu)
	;
	;   �E����     InitMenu
	;   �E����     �Ȃ�
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   �Ȃ��i�������s�j
	;*******************************************************************************
	dim hMenu,MAX_MENU : cMenu=0 : init=1
	return

	#defcfunc Create_Menu int prm1
	;*******************************************************************************
	;   ���j���[���쐬 (Create_Menu)
	;
	;   �߂�l : ���� hmenu=���j���[�̃n���h��, ���s hmenu<=0�̒l
	;
	;   �E����     hmenu = Create_Menu(menu_ID)
	;   �E����     menu_ID (int) : 0�`MAX_MENU ���j���[ID
	;   �E�^�C�v   ���[�U�[��`�֐�
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   hmenu=Create_Menu(0)  ;Menu bar
	;   hmenu=Create_Menu(1)  ;Popup Menu
	;*******************************************************************************
	MenuID=prm1

	;��note : ID=0 ... Window�p Menu bar ����ȊO Popup Menu
	if init==0 : InitMenu
	if (MenuID<0)||(MenuID>=MAX_MENU) : return 0
	if MenuID{
		;��Popup Menu
		if hMenu(MenuID) : DestroyMenu hMenu(MenuID)
		CreatePopupMenu : hMenu(MenuID)=stat
		ret=stat
	}else{
		;��Window Menu
		SetMenu hwnd,0
		if hMenu(MenuID) : DestroyMenu hMenu(MenuID)
		CreateMenu : hMenu(MenuID)=stat
		ret=stat
	}
	cMenu=MenuID
	return ret

	#deffunc SetMenumode int prm1
	;*******************************************************************************
	;   ���j���[���ړ��샂�[�h�ݒ� (SetMenumode)
	;
	;   �߂�l : stat=���j���[�n���h�� 
	;
	;   �E����     SetMenumode Mode
	;   �E����     Mode (int) : 0 or 0�ȊO �\�� or ��\���̃��[�h
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   SetMenumode 1
	;*******************************************************************************
	Mode=prm1

	;�����[�h = 0�ȊO�̂Ƃ��AID0�̃��j���[���E�B���h�E�ɕ\��
	;�����[�h = 0 ��\��
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
	;   ���j���[���ڑ�����I�� (SelectMenu)
	;
	;   �߂�l : ���� stat=0, ���s stat=-1
	;
	;   �E����     SelectMenu menu_ID
	;   �E����     menu_ID (int) : 0�`MAX_MENU ���ڑ���惁�j���[ID
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   SelectMenu 1
	;*******************************************************************************
	MenuID=prm1

	if init==0 : InitMenu
	if (MenuID<0)||(MenuID>=MAX_MENU) : return -1
	cMenu=MenuID
	return 0

	#deffunc Append_Menu str prm1,int prm2,int prm3
	;*******************************************************************************
	;   ���j���[���ڂ�ǉ� (Append_Menu)
	;
	;   �߂�l : ���� stat=0, ���s stat=-1
	;
	;   �E����     Append_Menu String,ItemID,Flags
	;   �E����     String (str) : �ǉ����ږ������� or ������^�ϐ�
	;              ItemID (int) : ����ID
	;              Flags  (int) : 0�`(0) �t���O(MF_POPUP,MF_GRAYED,MF_CHECKED)
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
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
	;   ���j���[���ڂ�}�� (Insert_Menu)
	;
	;   �߂�l : stat=���j���[�n���h��, ���s stat=-1
	;
	;   �E����     Insert_Menu Position,String,ItemID,Flags,Mode
	;   �E����     Position (int) : 0�`(0) �}���ʒu
	;              String   (str) : �}�����ږ������� or ������^�ϐ�
	;              ItemID   (int) : ����ID
	;              Flags    (int) : 0�`(0) �t���O(MF_SEPARATOR,MF_POPUP,MF_GRAYED,MF_CHECKED)
	;              Mode     (int) : �ʒu���[�h (0=MF_BYCOMMAND or 1=MF_BYPOSITION)
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   Insert_Menu 1,"",0,MF_SEPARATOR   ;�Z�p���[�^��}��
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
	;   ���j���[���ڂ�ύX (Modify_Menu)
	;
	;   �߂�l : stat=���j���[�n���h��, ���s stat=-1
	;
	;   �E����     Modify_Menu Position,String,ItemID,Flags,Mode
	;   �E����     Position (int) : 0�`(0) �}���ʒu
	;              String   (str) : �ύX���ږ������� or ������^�ϐ�
	;              ItemID   (int) : ����ID
	;              Flags    (int) : 0�`(0) �t���O(MF_SEPARATOR,MF_POPUP,MF_GRAYED,MF_CHECKED)
	;              Mode     (int) : �ʒu���[�h (0=MF_BYCOMMAND or 1=MF_BYPOSITION)
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   Modify_Menu 0,"�T���v��",1,MF_GRAYED
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
	;   ���j���[���ڂ��폜 (Remove_Menu)
	;
	;   �߂�l : stat=���j���[�n���h��, ���s stat=-1
	;
	;   �E����     Remove_Menu Position,Mode
	;   �E����     Position (int) : 0�`(0) �}���ʒu
	;              Mode     (int) : �ʒu���[�h (0=MF_BYCOMMAND or 1=MF_BYPOSITION)
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
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
	;   ���ڂ̃`�F�b�N�}�[�N��\���E��\���ݒ� (CheckMenu_Item)
	;
	;   �߂�l : stat=�`�G�b�N���, ���s stat=-1
	;
	;   �E����     CheckMenu_Item Position,Flags,Mode
	;   �E����     Position (int) : 0�`(0) �`�F�b�N�}�[�N�ʒu
	;              Flags    (int) : 0�`(0) �t���O(MF_CHECKED,MF_UNCHECKED)
	;              Mode     (int) : �ʒu���[�h (0=MF_BYCOMMAND or 1=MF_BYPOSITION)
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   CheckMenu_Item 1,MF_CHECKED,0
	;*******************************************************************************
	Position=prm1 : if Position<=0 : Position=0
	Flags   =prm2 : if Flags<=0    : Flags=0
	Mode    =prm3 : if Mode<=0     : Mode=0

	;���X�e�[�^�X�́AMF_CHECKED��MF_UNCHECKED
	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if Mode  : opt=MF_BYCOMMAND : else : opt=MF_BYPOSITION
	if Flags : Flags=MF_CHECKED : else : Flags=MF_UNCHECKED
	CheckMenuItem hMenu(cMenu),Position,Flags|opt
	ret=stat/MF_CHECKED
	return ret

	#deffunc EnableMenu_Item int prm1,int prm2,int prm3
	;*******************************************************************************
	;   ���ڂ̑I���\��Ԃ�ύX (EnableMenu_Item)
	;
	;   �߂�l : stat=�I�����, ���s stat=-1
	;
	;   �E����     EnableMenu_Item Position,Flags,Mode
	;   �E����     Position (int) : 0�`(0) �`�F�b�N�}�[�N�ʒu
	;              Flags    (int) : 0�`(0) �t���O(MF_ENABLED,MF_DISABLED,MF_GRAYED)
	;              Mode     (int) : �ʒu���[�h (0=MF_BYCOMMAND or 1=MF_BYPOSITION)
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   EnableMenu_Item 5,MF_ENABLED,0
	;*******************************************************************************
	Position=prm1 : if Position<=0 : Position=0
	Flags   =prm2 : if Flags<=0    : Flags=0
	Mode    =prm3 : if Mode<=0     : Mode=0

	;���X�e�[�^�X�́AMF_ENABLED, MF_DISABLED, MF_GRAYED
	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if Mode : opt=MF_BYCOMMAND : else : opt=MF_BYPOSITION
	EnableMenuItem hMenu(cMenu),Position,Flags|opt
	return stat

	#deffunc GetMenu_State int prm1,int prm2
	;*******************************************************************************
	;   ���j���[���ڂ̏�Ԃ��擾 (GetMenu_State)
	;
	;   �߂�l : stat=���ڂ̃X�e�[�^�X, ���s stat=-1, refstr=�\�����̕�����
	;
	;   �E����     GetMenu_State Position,Mode
	;   �E����     Position (int) : 0�`(0) ���ڈʒu
	;              Mode     (int) : �ʒu���[�h (0=MF_BYCOMMAND or 1=MF_BYPOSITION)
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
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
	;   ���j���[���ڂ̏�Ԃ��擾(�E�N���b�N���j���[�p) (TrackPopup_Menu)
	;
	;   �߂�l : stat=���j���[���I�����ꂽ��I�����ꂽ����ID(CommandID), ���s stat=-1
	;
	;   �E����     TrackPopup_Menu x,y,Flags
	;   �E����     x     (int) : mouse x (�ʏ��-1���w�肷��)
	;              y     (int) : mouse y (�ʏ��-1���w�肷��)
	;              Flags (int) : 0
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   TrackPopup_Menu -1,-1
	;   itemID=stat
	;*******************************************************************************
	x    =prm1        ;(Screen���W�n)
	y    =prm2        ;(Screen���W�n)
	Flags=prm3

	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if x<0 : x=ginfo(0)  ;prmx (HSP Ver2.x)
	if y<0 : y=ginfo(1)  ;prmy (HSP Ver2.x)
	TrackPopupMenu hMenu(cMenu),Flags|TPM_RETURNCMD,x,y,0,hwnd,0
	return stat

	#defcfunc GetmenuHandle
	;*******************************************************************************
	;   ���j���[�n���h�����擾 (GetmenuHandle)
	;
	;   �߂�l : ret=�I�𒆂̃��j���[�n���h��
	;
	;   �E����     ret=GetHandle()
	;   �E����     �Ȃ�
	;   �E�^�C�v   ���[�U�[��`�֐�
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   selMenuhwnd=GetmenuHandle()
	;*******************************************************************************
	if init==0 : InitMenu
	return hMenu(cMenu)

	#deffunc Destroy_Menu
	;*******************************************************************************
	;   ���j���[���폜 (Destroy_Menu)
	;
	;   �E����     Destroy_Menu
	;   �E����     �Ȃ�
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   Destroy_Menu
	;*******************************************************************************
	if init==0 : InitMenu
	if hMenu(cMenu)==0 : return -1
	if cMenu==0 : SetMenumode
	DestroyMenu hMenu(cMenu)
	return stat

	#deffunc DestroyAllMenu
	;*******************************************************************************
	;   ���ׂẴ��j���[���폜 (DestroyAllMenu)
	;
	;   �E����     DestroyAllMenu
	;   �E����     �Ȃ�
	;   �E�^�C�v   ���W���[������
	;
	;-- (NOTE) ---------------------------------------------------------------------
	;
	;   (�g�p��)
	;   DestroyAllMenu
	;*******************************************************************************
	if init==0 : return -1
	SetMenumode
	repeat MAX_MENU
		if hMenu(cnt) : DestroyMenu hMenu(cnt)
	loop
	return 0
	#global

	InitMenu   ;//���������s

#endif
#endif
;--------------------------------------------------------------- (EOF) ---------
