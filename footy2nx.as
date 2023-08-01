;===============================================================================
; ::::: Footy2 Edit Control Header (footy2nx.as) for HSP3.1 ::::::    2007.10.22
;
;   Footy2.h (Ver2.0.1.3)
;   Footy�e�L�X�g�G�f�B�^�R���g���[���Q
;   (C)2004-2007 ShinjiWatanabe
;   http://www.hpp.be/
;
;                                                HSP3�łֈڐA HSP-NEXT Sakura.
;===============================================================================
#ifdef __hsp30__
#ifndef __FOOTY2__
#define  __FOOTY2__

	;***** TextModifiedCause (�e�L�X�g���ҏW���ꂽ����) *****
	#enum MODIFIED_CAUSE_CHAR		=	0			; ���������͂��ꂽ(IME�I�t)
	#enum MODIFIED_CAUSE_IME						; ���������͂��ꂽ(IME�I��)
	#enum MODIFIED_CAUSE_DELETE						; Delete�L�[���������ꂽ
	#enum MODIFIED_CAUSE_BACKSPACE					; BackSpace���������ꂽ
	#enum MODIFIED_CAUSE_ENTER						; Enter�L�[���������ꂽ
	#enum MODIFIED_CAUSE_UNDO						; ���ɖ߂����������s���ꂽ
	#enum MODIFIED_CAUSE_REDO						; ��蒼�����������s���ꂽ
	#enum MODIFIED_CAUSE_CUT						; �؂��菈�������s���ꂽ
	#enum MODIFIED_CAUSE_PASTE						; �\��t�����������s���ꂽ
	#enum MODIFIED_CAUSE_INDENT						; �C���f���g���ꂽ
	#enum MODIFIED_CAUSE_UNINDENT					; �t�C���f���g���ꂽ
	#enum MODIFIED_CAUSE_TAB						; �^�u�L�[��������āA�^�u�������}�����ꂽ

	;***** �G���[�R�[�h *****
	#const FOOTY2ERR_NONE				0			; �֐�����������
	#const FOOTY2ERR_ARGUMENT			-1			; ������������
	#const FOOTY2ERR_NOID				-2			; ID��������Ȃ�
	#const FOOTY2ERR_MEMORY				-3			; �������[�s��
	#const FOOTY2ERR_NOUNDO				-4			; �A���h�D��񂪂���ȑO�Ɍ�����Ȃ�
	#const FOOTY2ERR_NOTSELECTED		-5			; �I������Ă��Ȃ�
	#const FOOTY2ERR_UNKNOWN			-6			; �s���ȃG���[
	#const FOOTY2ERR_NOTYET				-7			; ������(���߂�Ȃ���)
	#const FOOTY2ERR_404				-8			; �t�@�C����������Ȃ��A���������񂪌�����Ȃ�
	#const FOOTY2ERR_NOTACTIVE			-9			; �A�N�e�B�u�ȃr���[�͑��݂��܂���
	#const FOOTY2ERR_ENCODER			-10			; �����R�[�h�̃G���R�[�_��������܂���
													; (�t�@�C���̃G���R�[�h�`�����s���ł��A�o�C�i���Ƃ�)
	#const FOOTY2ERR_NOT_SELECTING		-11			; �I�����Ă��Ȃ�


	;//////////////////////////////// �萔�̐錾 ////////////////////////////////

	;***** UrlType (URL�^�C�v) *****
	#enum URLTYPE_HTTP				=	0			; http
	#enum URLTYPE_HTTPS								; https
	#enum URLTYPE_FTP								; ftp
	#enum URLTYPE_MAIL								; ���[���A�h���X

	;***** ViewMode (�r���[���[�h) *****
	#enum VIEWMODE_NORMAL			=	0			; �V���O�����[�h
	#enum VIEWMODE_VERTICAL							; �c����
	#enum VIEWMODE_HORIZONTAL						; ������
	#enum VIEWMODE_QUAD								; �l����
	#enum VIEWMODE_INVISIBLE						; ��\��

	;***** EmpMode (�d�������[�h) *****
	#enum EMP_INVALIDITY			=	0			; ����
	#enum EMP_WORD									; �P�������
	#enum EMP_LINE_AFTER							; ����ȍ~�`�s��
	#enum EMP_LINE_BETWEEN							; ��̕����̊ԁi����s�Ɍ���E��̕�������w��j
	#enum EMP_MULTI_BETWEEN							; ��̕����̊ԁi�����s�ɂ킽��E��̕�������w��j

	;***** ColorPos (�F�w�荀�ڈʒu) *****
	#enum CP_TEXT					=	0			; �ʏ�̕���
	#enum CP_BACKGROUND								; �w�i�F
	#enum CP_CRLF									; ���s�}�[�N
	#enum CP_HALFSPACE								; ���p�X�y�[�X
	#enum CP_NORMALSPACE							; �S�p�X�y�[�X
	#enum CP_TAB									; �^�u����
	#enum CP_EOF									; [EOF]
	#enum CP_UNDERLINE								; �L�����b�g�̉��̃A���_�[���C��
	#enum CP_LINENUMBORDER							; �s�ԍ��ƃe�L�X�g�G�f�B�^�̋��E��
	#enum CP_LINENUMTEXT							; �s�ԍ��e�L�X�g
	#enum CP_CARETLINE								; �s�ԍ��̈�ɂ�����L�����b�g�ʒu����
	#enum CP_RULERBACKGROUND						; ���[���[�̔w�i�F
	#enum CP_RULERTEXT								; ���[���[�̃e�L�X�g
	#enum CP_RULERLINE								; ���[���[��̐�
	#enum CP_CARETPOS								; ���[���[�ɂ�����L�����b�g�ʒu����
	#enum CP_URLTEXT								; URL����
	#enum CP_URLUNDERLINE							; URL���ɕ\�������A���_�[���C��
	#enum CP_MAILTEXT								; ���[���A�h���X����
	#enum CP_MAILUNDERLINE							; ���[�����ɕ\������镶����
	#enum CP_HIGHLIGHTTEXT							; �n�C���C�g�e�L�X�g
	#enum CP_HIGHLIGHTBACKGROUND					; �n�C���C�g�w�i�F

	;***** LineMode (���s�R�[�h) *****
	#enum LM_AUTOMATIC				=	0			; ����
	#enum LM_CRLF									; CrLf�R�[�h
	#enum LM_CR										; Cr�R�[�h
	#enum LM_LF										; Lf�R�[�h
	#enum LM_ERROR									; �G���[���ʗp�F�߂�l��p�ł�

	;***** CharSetMode (�L�����N�^�Z�b�g���[�h) *****
	#enum CSM_AUTOMATIC				=	0			; �������[�h(�ʏ�͂�����g�p����)

	; (���{��)
	#enum CSM_SHIFT_JIS_2004						; ShiftJIS��JIS X 0213:2004�g��(WindowsVista�W��)
	#enum CSM_EUC_JIS_2004							; EUC-JP��JIS X 0213:2004�g��
	#enum CSM_ISO_2022_JP_2004						; JIS�R�[�h��JIS X 0213:2004�g��

	; (ISO 8859)
	#enum CSM_ISO8859_1								; �����[���b�p(Latin1)
	#enum CSM_ISO8859_2								; �����[���b�p(Latin2)
	#enum CSM_ISO8859_3								; �G�X�y�����g�ꑼ(Latin3)
	#enum CSM_ISO8859_4								; �k���[���b�p(Latin4)
	#enum CSM_ISO8859_5								; �L����
	#enum CSM_ISO8859_6								; �A���r�A
	#enum CSM_ISO8859_7								; �M���V��
	#enum CSM_ISO8859_8								; �w�u���C
	#enum CSM_ISO8859_9								; �g���R(Latin5)
	#enum CSM_ISO8859_10							; �k��(Latin6)
	#enum CSM_ISO8859_11							; �^�C
	; (ISO8859-12��1997�N�ɔj������܂���)
	#enum CSM_ISO8859_13							; �o���g�����̌���
	#enum CSM_ISO8859_14							; �P���g��
	#enum CSM_ISO8859_15							; ISO 8859-1�̕ό`��
	#enum CSM_ISO8859_16							; ���새�[���b�p

	; (Unicode)
	#enum CSM_UTF8									; BOM����UTF8
	#enum CSM_UTF8_BOM								; BOM�t��UTF8
	#enum CSM_UTF16_LE								; BOM����UTF16���g���G���f�B�A��
	#enum CSM_UTF16_LE_BOM							; BOM�t��UTF16���g���G���f�B�A��
	#enum CSM_UTF16_BE								; BOM����UTF16�r�b�O�G���f�B�A��
	#enum CSM_UTF16_BE_BOM							; BOM�t��UTF16�r�b�O�G���f�B�A��
	#enum CSM_UTF32_LE								; BOM����UTF32���g���G���f�B�A��
	#enum CSM_UTF32_LE_BOM							; BOM�t��UTF32���g���G���f�B�A��
	#enum CSM_UTF32_BE								; BOM����UTF32�r�b�O�G���f�B�A��
	#enum CSM_UTF32_BE_BOM							; BOM�t��UTF32�r�b�O�G���f�B�A��
	
	; ���������p(�g�p���Ȃ��ł�������)
	#enum CSM_ERROR									; �G���[

	;***** FontMode (�t�H���g) *****
	#enum FFM_ANSI_CHARSET			=	0			; ANSI����
	#enum FFM_BALTIC_CHARSET						; �o���g����
	#enum FFM_BIG5_CHARSET							; �ɑ̎������ꕶ��
	#enum FFM_EASTEUROPE_CHARSET					; �����[���b�p����
	#enum FFM_GB2312_CHARSET						; �ȑ̒����ꕶ��
	#enum FFM_GREEK_CHARSET							; �M���V������
	#enum FFM_HANGUL_CHARSET						; �n���O������
	#enum FFM_RUSSIAN_CHARSET						; �L��������
	#enum FFM_SHIFTJIS_CHARSET						; ���{��
	#enum FFM_TURKISH_CHARSET						; �g���R��
	#enum FFM_VIETNAMESE_CHARSET					; �x�g�i����
	#enum FFM_ARABIC_CHARSET						; �A���r�A��
	#enum FFM_HEBREW_CHARSET						; �w�u���C��
	#enum FFM_THAI_CHARSET							; �^�C��
	
	; ���������p(�g�p���Ȃ��ł�������)
	#enum FFM_NUM_FONTS								; �t�H���g�̐�

	;***** �s�A�C�R�� *****
	#define LINEICON_ATTACH				$00000001	; �N���b�v�̂悤�ȃA�C�R��
	#define LINEICON_BACK				$00000002	; �߂�A�C�R��
	#define LINEICON_CHECKED			$00000004	; �`�F�b�N�{�b�N�X�̃`�F�b�N���͂���������
	#define LINEICON_UNCHECKED			$00000008	; �`�F�b�N�{�b�N�X�̃`�F�b�N���Ȃ�����
	#define LINEICON_CANCEL				$00000010	; �L�����Z���A�C�R��(�u���[�N�|�C���g�ȂǂɎg������)
	#define LINEICON_CLOCK				$00000020	; ���v�A�C�R��
	#define LINEICON_CONTENTS			$00000040	; �R���e���c���܂ރA�C�R��
	#define LINEICON_DB_CANCEL			$00000080	; �f�[�^�x�[�X�p�A�L�����Z���A�C�R��
	#define LINEICON_DB_DELETE			$00000100	; �f�[�^�x�[�X�p�A�폜�A�C�R��
	#define LINEICON_DB_FIRST			$00000200	; �f�[�^�x�[�X�p�A�ŏ��̍��ڃA�C�R��
	#define LINEICON_DB_EDIT			$00000400	; �f�[�^�x�[�X�p�A�ҏW�A�C�R��
	#define LINEICON_DB_INSERT			$00000800	; �f�[�^�x�[�X�p�A�ǉ��A�C�R��
	#define LINEICON_DB_LAST			$00001000	; �f�[�^�x�[�X�p�A�Ō�̍��ڃA�C�R��
	#define LINEICON_DB_NEXT			$00002000	; �f�[�^�x�[�X�p�A���̍��ڃA�C�R��
	#define LINEICON_DB_POST			$00004000	; �f�[�^�x�[�X�p�A�`�F�b�N�A�C�R��
	#define LINEICON_DB_PREVIOUS		$00008000	; �f�[�^�x�[�X�p�A�O�̍��ڃA�C�R��
	#define LINEICON_DB_REFRESH			$00010000	; �f�[�^�x�[�X�p�A�ĕ`��A�C�R��
	#define LINEICON_DELETE				$00020000	; �폜�A�C�R��
	#define LINEICON_EXECUTE			$00040000	; ���s�A�C�R��
	#define LINEICON_FAVORITE			$00080000	; ���C�ɓ���A�C�R��
	#define LINEICON_BLUE				$00100000	; �F�t���O�A�C�R��
	#define LINEICON_GREEN				$00200000	; �ΐF�t���O�A�C�R��
	#define LINEICON_RED				$00400000	; �ԐF�t���O�A�C�R��
	#define LINEICON_FORWARD			$00800000	; �O�֐i�ރA�C�R��
	#define LINEICON_HELP				$01000000	; �w���v�A�C�R��
	#define LINEICON_INFORMATION		$02000000	; ���A�C�R��
	#define LINEICON_KEY				$04000000	; �Í����A�C�R��
	#define LINEICON_LOCK				$08000000	; ���b�N�A�C�R��
	#define LINEICON_RECORD				$10000000	; �L�^�A�C�R��
	#define LINEICON_TICK				$20000000	; �`�F�b�N�A�C�R��
	#define LINEICON_TIPS				$40000000	; Tips�A�C�R��
	#define LINEICON_WARNING			$80000000	; �x���A�C�R��(�R���p�C���G���[���ɐ���)

	;***** �����\�����[�h *****
	#define EMPFLAG_BOLD				$00000001	; �����ɂ���
	#define EMPFLAG_NON_CS				$00000002	; �啶���Ə���������ʂ��Ȃ�
	#define EMPFLAG_HEAD				$00000004	; ���ɂ���Ƃ��̂�

	;***** �G�f�B�^�}�[�N�\���A��\���̐ݒ� *****
	#define EDM_HALF_SPACE				$00000001	; ���p�X�y�[�X��\�����邩
	#define EDM_FULL_SPACE				$00000002	; �S�p�X�y�[�X��\�����邩
	#define EDM_TAB						$00000004	; �^�u�}�[�N��\�����邩
	#define EDM_LINE					$00000008	; ���s�}�[�N��\�����邩
	#define EDM_EOF						$00000010	; [EOF]�}�[�N��\�����邩
	
	#define EDM_SHOW_ALL				$FFFFFFFF	; �S�ĕ\������
	#define EDM_SHOW_NONE				$00000000	; �����\�����Ȃ�

	;***** �����t���O *****
	#define SEARCH_FROMCURSOR			$00000001	; ���݂̃J�[�\���ʒu���猟������
	#define SEARCH_BACK					$00000002	; �������Ɍ������������s����
	#define SEARCH_REGEXP				$00000004	; ���K�\���𗘗p����
	#define SEARCH_NOT_REFRESH			$00000008	; �������ʂ��ĕ`�悵�Ȃ�
	#define SEARCH_BEEP_ON_404			$00000010	; ������Ȃ������Ƃ��Ƀr�[�v�����Ȃ炷
	#define SEARCH_NOT_ADJUST_VIEW		$00000020	; ���������Ƃ��ɃL�����b�g�ʒu�փX�N���[���o�[��ǐ������Ȃ�

	;///////// �Ɨ����x�� /////////
	;***** ASCII�L���p�t���O *****
	#define EMP_IND_PARENTHESIS			$00000001	; �O��Ɋۊ���()�����邱�Ƃ�������
	#define EMP_IND_BRACE				$00000002	; �O��ɒ�����{}�����邱�Ƃ�������
	#define EMP_IND_ANGLE_BRACKET		$00000004	; �O��ɎR�`����<>�����邱�Ƃ�������
	#define EMP_IND_SQUARE_BRACKET		$00000008	; �O��Ɋe����[]�����邱�Ƃ�������
	#define EMP_IND_QUOTATION			$00000010	; �O��ɃR�[�e�[�V����'"�����邱�Ƃ�������
	#define EMP_IND_UNDERBAR			$00000020	; �O��ɃA���_�[�o�[_�����邱�Ƃ�������
	#define EMP_IND_OPERATORS			$00000040	; �O��ɉ��Z�q + - * / % ^ = �����邱�Ƃ�������
	#define EMP_IND_OTHER_ASCII_SIGN	$00000080	; �O�q�̂��̂������S�Ă�ASCII�L�� # ! $ & | \ @ ? , .
	
	; ASCII��������w�肷��t���O
	#define EMP_IND_NUMBER				$00000100	; �O��ɐ�����������
	#define EMP_IND_CAPITAL_ALPHABET	$00000200	; �O��ɑ啶���A���t�@�x�b�g��������
	#define EMP_IND_SMALL_ALPHABET		$00000400	; �O��ɏ������A���t�@�x�b�g��������
	
	; �󔒂��w�肷��t���O
	#define EMP_IND_SPACE				$00001000	; �O��ɔ��p�X�y�[�X��������
	#define EMP_IND_FULL_SPACE			$00002000	; �O��ɑS�p�X�y�[�X��������
	#define EMP_IND_TAB					$00004000	; �O��Ƀ^�u��������

	; ���̂ق��̕�����
	#define EMP_IND_JAPANESE			$00010000	; ���{��
	#define EMP_IND_KOREAN				$00020000	; �؍���
	#define EMP_IND_EASTUROPE			$00040000	; �����[���b�p
	#define EMP_IND_OTHERS				$80000000	; ��L�ȊO

	; �ȗ��`(��ɂ������g�p����Ǝw�肪�y�ł�)
	#define EMP_IND_ASCII_SIGN			$000000FF	; �S�Ă�ASCII�L�����������
	#define EMP_IND_ASCII_LETTER		$00000F00	; �S�Ă�ASCII������������(�����ƃA���t�@�x�b�g)
	#define EMP_IND_BLANKS				$0000F000	; �S�Ă̋󔒕������������
	#define EMP_IND_OTHER_CHARSETS		$FFFF0000	; �S�ẴL�����N�^�Z�b�g��������
	#define EMP_IND_ALLOW_ALL			$FFFFFFFF	; ���ł�OK

	;***** �܂�Ԃ����[�h *****
	#define LAPELFLAG_ALL				$FFFFFFFF	; �ȉ��̃t���O�S�Ă�I������
	#define LAPELFLAG_NONE				$00000000	; �����L���ɂ��Ȃ�
	#define LAPELFLAG_WORDBREAK			$00000001	; �p�����[�h���b�v
	#define LAPELFLAG_JPN_PERIOD		$00000002	; ���{��̋�Ǔ_�Ɋւ���֑�����
	#define LAPELFLAG_JPN_QUOTATION		$00000004	; ���{��̃J�M���ʂɊւ���֑�����

	;***** ���l�擾 (SetMetricsCod) *****
	#enum SM_LAPEL_COLUMN			=	0			; �܂�Ԃ��ʒu(����)
	#enum SM_LAPEL_MODE								; �܂�Ԃ����[�h
	#enum SM_MARK_VISIBLE							; �}�[�N�̕\�����
	#enum SM_LINENUM_WIDTH							; ���[�̍s�ԍ��̕�(�s�N�Z���A-1�Ńf�t�H���g)
	#enum SM_RULER_HEIGHT							; ��̃��[���[�̍���(�s�N�Z���A-1�Ńf�t�H���g)

	;//////////////////////////////// �֐��̐錾 ////////////////////////////////

	#uselib "Footy2.dll"

	;***** �o�[�W�����֘A *****
	#cfunc GetFooty2Ver "GetFooty2Ver"										; Footy�̃o�[�W�������擾����B
	#cfunc GetFooty2BetaVer "GetFooty2BetaVer"								; Footy�̃��o�[�W�������擾����B

	;***** �E�B���h�E�֘A *****
	#cfunc Footy2Create "Footy2Create" int,int,int,int,int,int				; Footy���쐬����B
	#cfunc Footy2Delete "Footy2Delete" int									; �m�ۂ��ꂽID�̃f�[�^���������ă������̈���m�ۂ���B
	#cfunc Footy2Move "Footy2Move" int,int,int,int,int						; Footy�E�B���h�E���ړ�����B
	#cfunc Footy2ChangeView "Footy2ChangeView" int,int						; �r���[���[�h�̕ύX
	#func  Footy2SetFocus "Footy2SetFocus" int,int							; �t�H�[�J�X�ݒ�
	#cfunc Footy2GetWnd "Footy2GetWnd" int,int								; Footy�̃E�B���h�E�n���h�����擾
	#cfunc Footy2GetWndVSplit "Footy2GetWndVSplit" int						; �c�����p�o�[�̃E�B���h�E�n���h�����擾
	#cfunc Footy2GetWndHSplit "Footy2GetWndHSplit" int						; �������p�o�[�̃E�B���h�E�n���h�����擾
	#cfunc Footy2GetActiveView "Footy2GetActiveView" int					; �A�N�e�B�u�ȃr���[���擾
	#func  Footy2Refresh "Footy2Refresh" int								; �ĕ`�揈��

	;***** �ҏW�n *****
	#func  Footy2Copy "Footy2Copy" int										; �N���b�v�{�[�h�փR�s�[
	#func  Footy2Cut "Footy2Cut" int										; �N���b�v�{�[�h�փJ�b�g
	#func  Footy2Paste "Footy2Paste" int									; �N���b�v�{�[�h����y�[�X�g
	#func  Footy2Undo "Footy2Undo" int										; �A���h�D
	#func  Footy2Redo "Footy2Redo" int										; ���h�D
	#cfunc Footy2IsEdited "Footy2IsEdited" int								; ���h�D����Ă��邩�ǂ���
	#func  Footy2SelectAll "Footy2SelectAll" int,int						; �S�đI��
	#cfunc Footy2ShiftLock "Footy2ShiftLock" int,int						; �V�t�g���b�N���s�����ǂ���
	#cfunc Footy2IsShiftLocked "Footy2IsShiftLocked" int					; �V�t�g���b�N���s���Ă��邩�ǂ����擾

	;***** �����n *****
	#define Footy2Search	Footy2SearchA									; �G�f�B�^�����@�\
	#cfunc  Footy2SearchA "Footy2SearchA" int,sptr,int						; (ANSI��)
	#cfunc  Footy2SearchW "Footy2SearchW" int,wptr,int						; (UNICODE��)

	;***** �t�@�C���ҏW *****
	#func   Footy2CreateNew "Footy2CreateNew" int							; �t�@�C���̐V�K�쐬
	#define Footy2TextFromFile	Footy2TextFromFileA							; �e�L�X�g�t�@�C������f�[�^��ǂݍ���
	#cfunc  Footy2TextFromFileA "Footy2TextFromFileA" int,sptr,int			; (ANSI��)
	#cfunc  Footy2TextFromFileW "Footy2TextFromFileW" int,wptr,int			; (UNICODE��)
	#define Footy2SaveToFile	Footy2SaveToFileA							; ���݂̃e�L�X�g��Ԃ��t�@�C���ւ̏�������
	#cfunc  Footy2SaveToFileA "Footy2SaveToFileA" int,sptr,int,int			; (ANSI��)
	#cfunc  Footy2SaveToFileW "Footy2SaveToFileW" int,wptr,int,int			; (UNICODE��)
	#cfunc  Footy2GetCharSet "Footy2GetCharSet" int							; �����R�[�h�Z�b�g���擾
	#cfunc  Footy2GetLineCode "Footy2GetLineCode" int						; ���s�R�[�h���擾

	;***** �����񏈗� *****
	#define Footy2SetSelText	Footy2SetSelTextA							; �I�𕶎�����Z�b�g
	#func   Footy2SetSelTextA "Footy2SetSelTextA" int,sptr					; (ANSI��)
	#func   Footy2SetSelTextW "Footy2SetSelTextW" int,wptr					; (UNICODE��)
	#define Footy2GetSelText	Footy2GetSelTextA							; �I�𕶎�����擾
	#cfunc  Footy2GetSelTextA "Footy2GetSelTextA" int,sptr,int,int			; (ANSI��)
	#cfunc  Footy2GetSelTextW "Footy2GetSelTextW" int,wptr,int,int			; (UNICODE��)
	#define Footy2SetText	Footy2SetTextA									; ������Z�b�g
	#func   Footy2SetTextA "Footy2SetTextA" int,sptr						; (ANSI��)
	#func   Footy2SetTextW "Footy2SetTextW" int,wptr						; (UNICODE��)
	#define Footy2GetTextLength	Footy2GetTextLengthA						; �����񒷂��擾
	#cfunc  Footy2GetTextLengthA "Footy2GetTextLengthA" int,int				; (ANSI��)
	#cfunc  Footy2GetTextLengthW "Footy2GetTextLengthW" int,int				; (UNICODE��)
	#define Footy2GetSelLength	Footy2GetSelLengthA							; �I�𕶎��񒷂����擾
	#cfunc  Footy2GetSelLengthA "Footy2GetSelLengthA" int,int				; (ANSI��)
	#cfunc  Footy2GetSelLengthW "Footy2GetSelLengthW" int,int				; (UNICODE��)
	#define Footy2GetText	Footy2GetTextA									; ������擾
	#cfunc  Footy2GetTextA "Footy2GetTextA" int,sptr,int,int				; (ANSI��)
	#cfunc  Footy2GetTextW "Footy2GetTextW" int,wptr,int,int				; (UNICODE��)
	#define Footy2GetLine	Footy2GetLineA									; �s�f�[�^���擾
	#cfunc  Footy2GetLineA "Footy2GetLineA" int,sptr,int,int				; (ANSI��)
	#cfunc  Footy2GetLineW "Footy2GetLineW" int,wptr,int,int				; (UNICODE��)
	#define Footy2SetLine	Footy2SetLineA									; �s�f�[�^��ݒ�
	#func   Footy2SetLineA "Footy2SetLineA" int,int,sptr,int				; (ANSI��)
	#func   Footy2SetLineW "Footy2SetLineW" int,int,wptr,int				; (UNICODE��)
	#define Footy2GetLineLength	Footy2GetLineLengthA						; �s���Ƃ̒����擾
	#cfunc  Footy2GetLineLengthA "Footy2GetLineLengthA" int,int				; (ANSI��)
	#cfunc  Footy2GetLineLengthW "Footy2GetLineLengthW" int,int				; (UNICODE��)
	#cfunc  Footy2GetLines "Footy2GetLines" int								; �s�̐����擾

	;***** �L�����b�g�E�I���n *****
	#cfunc  Footy2GetCaretPosition "Footy2GetCaretPosition" int,var,var		; ���݃L�����b�g������ʒu���擾
	#func   Footy2SetCaretPosition "Footy2SetCaretPosition" int,int,int,int	; �w�肳�ꂽ�ʒu�փL�����b�g���ړ�����
	#cfunc  Footy2GetSel "Footy2GetSel" int,var,var,var,var					; �w�肳�ꂽ�I����Ԃ��擾
	#func   Footy2SetSel "Footy2SetSel" int,int,int,int,int,int				; �e�L�X�g�ʒu�ł̃e�L�X�g��I��

	;***** �\�� *****
	#define Footy2AddEmphasis	Footy2AddEmphasisA							; �����\���̕�����ݒ�
	#func   Footy2AddEmphasisA "Footy2AddEmphasisA" int,sptr,sptr,int,int,int,int,int,int	; (ANSI��)
	#func   Footy2AddEmphasisW "Footy2AddEmphasisW" int,wptr,wptr,int,int,int,int,int,int	; (UNICODE��)
	#func   Footy2FlushEmphasis "Footy2FlushEmphasis" int					; �ݒ肳�ꂽ�F��������K�p
	#func   Footy2ClearEmphasis "Footy2ClearEmphasis" int					; �ݒ肳�ꂽ�F��������S�Ĕj��
	#func   Footy2SetFontSize "Footy2SetFontSize" int,int,int				; �S�̂̃t�H���g�̃T�C�Y��ݒ�
	#define Footy2SetFontFace	Footy2SetFontFaceA							; �w�肳�ꂽ��ނ̃t�H���g��ύX
	#func   Footy2SetFontFaceA "Footy2SetFontFaceA" int,int,sptr,int		; (ANSI��)
	#func   Footy2SetFontFaceW "Footy2SetFontFaceW" int,int,wptr,int		; (UNICODE��)
	#func   Footy2SetLineIcon "Footy2SetLineIcon" int,int,int,int			; �s�A�C�R����ݒ�
	#cfunc  Footy2GetLineIcon "Footy2GetLineIcon" int,int,sptr				; �w�肳�ꂽ�s�ԍ��ɐݒ肳�ꂽ�A�C�R�����擾

	;***** �ݒ�֘A *****
	#func   Footy2SetLapel "Footy2SetLapel" int,int,int,int					; �܂�Ԃ��̐ݒ�
	#func   Footy2SetMetrics "Footy2SetMetrics" int,int,int,int				; Footy�G�f�B�^�R���g���[���̐ݒ�
	#cfunc  Footy2GetMetrics "Footy2GetMetrics" int,int,var					; Footy2GetMetrics�֐��ȂǂŐݒ肵���l���擾
	#func   Footy2SetColor "Footy2SetColor" int,int,int,int					; �G�f�B�^�̊e���ʂ̐F��ݒ�
	#cfunc  Footy2GetVisibleColumns "Footy2GetVisibleColumns" int,int		; ���݃r���[�ŕ\�����Ă��錅�����擾
	#cfunc  Footy2GetVisibleLines "Footy2GetVisibleLines" int,int			; ���݃r���[�ŕ\�����Ă���s�����擾

	;***** �R�[���o�b�N�֐� (HSP���痘�p����ꍇ�́Ahscallbk.dll���K�v) *****
	#func   Footy2SetFuncFocus "Footy2SetFuncFocus" int,int,int,int
	#func   Footy2SetFuncMoveCaret "Footy2SetFuncMoveCaret" int,int,int,int
	#func   Footy2SetFuncTextModified "Footy2SetFuncTextModified" int,int,int
	#func   Footy2SetFuncInsertModeChanged "Footy2SetFuncInsertModeChanged" int,int,int

#endif
#endif
