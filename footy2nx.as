;===============================================================================
; ::::: Footy2 Edit Control Header (footy2nx.as) for HSP3.1 ::::::    2007.10.22
;
;   Footy2.h (Ver2.0.1.3)
;   Footyテキストエディタコントロール２
;   (C)2004-2007 ShinjiWatanabe
;   http://www.hpp.be/
;
;                                                HSP3版へ移植 HSP-NEXT Sakura.
;===============================================================================
#ifdef __hsp30__
#ifndef __FOOTY2__
#define  __FOOTY2__

	;***** TextModifiedCause (テキストが編集された原因) *****
	#enum MODIFIED_CAUSE_CHAR		=	0			; 文字が入力された(IMEオフ)
	#enum MODIFIED_CAUSE_IME						; 文字が入力された(IMEオン)
	#enum MODIFIED_CAUSE_DELETE						; Deleteキーが押下された
	#enum MODIFIED_CAUSE_BACKSPACE					; BackSpaceが押下された
	#enum MODIFIED_CAUSE_ENTER						; Enterキーが押下された
	#enum MODIFIED_CAUSE_UNDO						; 元に戻す処理が実行された
	#enum MODIFIED_CAUSE_REDO						; やり直し処理が実行された
	#enum MODIFIED_CAUSE_CUT						; 切り取り処理が実行された
	#enum MODIFIED_CAUSE_PASTE						; 貼り付け処理が実行された
	#enum MODIFIED_CAUSE_INDENT						; インデントされた
	#enum MODIFIED_CAUSE_UNINDENT					; 逆インデントされた
	#enum MODIFIED_CAUSE_TAB						; タブキーが押されて、タブ文字が挿入された

	;***** エラーコード *****
	#const FOOTY2ERR_NONE				0			; 関数が成功した
	#const FOOTY2ERR_ARGUMENT			-1			; 引数おかしい
	#const FOOTY2ERR_NOID				-2			; IDが見つからない
	#const FOOTY2ERR_MEMORY				-3			; メモリー不足
	#const FOOTY2ERR_NOUNDO				-4			; アンドゥ情報がこれ以前に見つからない
	#const FOOTY2ERR_NOTSELECTED		-5			; 選択されていない
	#const FOOTY2ERR_UNKNOWN			-6			; 不明なエラー
	#const FOOTY2ERR_NOTYET				-7			; 未実装(ごめんなさい)
	#const FOOTY2ERR_404				-8			; ファイルが見つからない、検索文字列が見つからない
	#const FOOTY2ERR_NOTACTIVE			-9			; アクティブなビューは存在しません
	#const FOOTY2ERR_ENCODER			-10			; 文字コードのエンコーダが見つかりません
													; (ファイルのエンコード形式が不正です、バイナリとか)
	#const FOOTY2ERR_NOT_SELECTING		-11			; 選択していない


	;//////////////////////////////// 定数の宣言 ////////////////////////////////

	;***** UrlType (URLタイプ) *****
	#enum URLTYPE_HTTP				=	0			; http
	#enum URLTYPE_HTTPS								; https
	#enum URLTYPE_FTP								; ftp
	#enum URLTYPE_MAIL								; メールアドレス

	;***** ViewMode (ビューモード) *****
	#enum VIEWMODE_NORMAL			=	0			; シングルモード
	#enum VIEWMODE_VERTICAL							; 縦分割
	#enum VIEWMODE_HORIZONTAL						; 横分割
	#enum VIEWMODE_QUAD								; 四分割
	#enum VIEWMODE_INVISIBLE						; 非表示

	;***** EmpMode (Ｅｍｐモード) *****
	#enum EMP_INVALIDITY			=	0			; 無効
	#enum EMP_WORD									; 単語を強調
	#enum EMP_LINE_AFTER							; それ以降～行末
	#enum EMP_LINE_BETWEEN							; 二つの文字の間（同一行に限る・二つの文字列を指定）
	#enum EMP_MULTI_BETWEEN							; 二つの文字の間（複数行にわたる・二つの文字列を指定）

	;***** ColorPos (色指定項目位置) *****
	#enum CP_TEXT					=	0			; 通常の文字
	#enum CP_BACKGROUND								; 背景色
	#enum CP_CRLF									; 改行マーク
	#enum CP_HALFSPACE								; 半角スペース
	#enum CP_NORMALSPACE							; 全角スペース
	#enum CP_TAB									; タブ文字
	#enum CP_EOF									; [EOF]
	#enum CP_UNDERLINE								; キャレットの下のアンダーライン
	#enum CP_LINENUMBORDER							; 行番号とテキストエディタの境界線
	#enum CP_LINENUMTEXT							; 行番号テキスト
	#enum CP_CARETLINE								; 行番号領域におけるキャレット位置強調
	#enum CP_RULERBACKGROUND						; ルーラーの背景色
	#enum CP_RULERTEXT								; ルーラーのテキスト
	#enum CP_RULERLINE								; ルーラー上の線
	#enum CP_CARETPOS								; ルーラーにおけるキャレット位置強調
	#enum CP_URLTEXT								; URL文字
	#enum CP_URLUNDERLINE							; URL下に表示されるアンダーライン
	#enum CP_MAILTEXT								; メールアドレス文字
	#enum CP_MAILUNDERLINE							; メール下に表示される文字列
	#enum CP_HIGHLIGHTTEXT							; ハイライトテキスト
	#enum CP_HIGHLIGHTBACKGROUND					; ハイライト背景色

	;***** LineMode (改行コード) *****
	#enum LM_AUTOMATIC				=	0			; 自動
	#enum LM_CRLF									; CrLfコード
	#enum LM_CR										; Crコード
	#enum LM_LF										; Lfコード
	#enum LM_ERROR									; エラー識別用：戻り値専用です

	;***** CharSetMode (キャラクタセットモード) *****
	#enum CSM_AUTOMATIC				=	0			; 自動モード(通常はこれを使用する)

	; (日本語)
	#enum CSM_SHIFT_JIS_2004						; ShiftJISのJIS X 0213:2004拡張(WindowsVista標準)
	#enum CSM_EUC_JIS_2004							; EUC-JPのJIS X 0213:2004拡張
	#enum CSM_ISO_2022_JP_2004						; JISコードのJIS X 0213:2004拡張

	; (ISO 8859)
	#enum CSM_ISO8859_1								; 西ヨーロッパ(Latin1)
	#enum CSM_ISO8859_2								; 東ヨーロッパ(Latin2)
	#enum CSM_ISO8859_3								; エスペラント語他(Latin3)
	#enum CSM_ISO8859_4								; 北ヨーロッパ(Latin4)
	#enum CSM_ISO8859_5								; キリル
	#enum CSM_ISO8859_6								; アラビア
	#enum CSM_ISO8859_7								; ギリシャ
	#enum CSM_ISO8859_8								; ヘブライ
	#enum CSM_ISO8859_9								; トルコ(Latin5)
	#enum CSM_ISO8859_10							; 北欧(Latin6)
	#enum CSM_ISO8859_11							; タイ
	; (ISO8859-12は1997年に破棄されました)
	#enum CSM_ISO8859_13							; バルト諸国の言語
	#enum CSM_ISO8859_14							; ケルト語
	#enum CSM_ISO8859_15							; ISO 8859-1の変形版
	#enum CSM_ISO8859_16							; 東南ヨーロッパ

	; (Unicode)
	#enum CSM_UTF8									; BOM無しUTF8
	#enum CSM_UTF8_BOM								; BOM付きUTF8
	#enum CSM_UTF16_LE								; BOM無しUTF16リトルエンディアン
	#enum CSM_UTF16_LE_BOM							; BOM付きUTF16リトルエンディアン
	#enum CSM_UTF16_BE								; BOM無しUTF16ビッグエンディアン
	#enum CSM_UTF16_BE_BOM							; BOM付きUTF16ビッグエンディアン
	#enum CSM_UTF32_LE								; BOM無しUTF32リトルエンディアン
	#enum CSM_UTF32_LE_BOM							; BOM付きUTF32リトルエンディアン
	#enum CSM_UTF32_BE								; BOM無しUTF32ビッグエンディアン
	#enum CSM_UTF32_BE_BOM							; BOM付きUTF32ビッグエンディアン
	
	; 内部処理用(使用しないでください)
	#enum CSM_ERROR									; エラー

	;***** FontMode (フォント) *****
	#enum FFM_ANSI_CHARSET			=	0			; ANSI文字
	#enum FFM_BALTIC_CHARSET						; バルト文字
	#enum FFM_BIG5_CHARSET							; 繁体字中国語文字
	#enum FFM_EASTEUROPE_CHARSET					; 東ヨーロッパ文字
	#enum FFM_GB2312_CHARSET						; 簡体中国語文字
	#enum FFM_GREEK_CHARSET							; ギリシャ文字
	#enum FFM_HANGUL_CHARSET						; ハングル文字
	#enum FFM_RUSSIAN_CHARSET						; キリル文字
	#enum FFM_SHIFTJIS_CHARSET						; 日本語
	#enum FFM_TURKISH_CHARSET						; トルコ語
	#enum FFM_VIETNAMESE_CHARSET					; ベトナム語
	#enum FFM_ARABIC_CHARSET						; アラビア語
	#enum FFM_HEBREW_CHARSET						; ヘブライ語
	#enum FFM_THAI_CHARSET							; タイ語
	
	; 内部処理用(使用しないでください)
	#enum FFM_NUM_FONTS								; フォントの数

	;***** 行アイコン *****
	#define LINEICON_ATTACH				$00000001	; クリップのようなアイコン
	#define LINEICON_BACK				$00000002	; 戻るアイコン
	#define LINEICON_CHECKED			$00000004	; チェックボックスのチェックがはいったもの
	#define LINEICON_UNCHECKED			$00000008	; チェックボックスのチェックがないもの
	#define LINEICON_CANCEL				$00000010	; キャンセルアイコン(ブレークポイントなどに使えそう)
	#define LINEICON_CLOCK				$00000020	; 時計アイコン
	#define LINEICON_CONTENTS			$00000040	; コンテンツを含むアイコン
	#define LINEICON_DB_CANCEL			$00000080	; データベース用、キャンセルアイコン
	#define LINEICON_DB_DELETE			$00000100	; データベース用、削除アイコン
	#define LINEICON_DB_FIRST			$00000200	; データベース用、最初の項目アイコン
	#define LINEICON_DB_EDIT			$00000400	; データベース用、編集アイコン
	#define LINEICON_DB_INSERT			$00000800	; データベース用、追加アイコン
	#define LINEICON_DB_LAST			$00001000	; データベース用、最後の項目アイコン
	#define LINEICON_DB_NEXT			$00002000	; データベース用、次の項目アイコン
	#define LINEICON_DB_POST			$00004000	; データベース用、チェックアイコン
	#define LINEICON_DB_PREVIOUS		$00008000	; データベース用、前の項目アイコン
	#define LINEICON_DB_REFRESH			$00010000	; データベース用、再描画アイコン
	#define LINEICON_DELETE				$00020000	; 削除アイコン
	#define LINEICON_EXECUTE			$00040000	; 実行アイコン
	#define LINEICON_FAVORITE			$00080000	; お気に入りアイコン
	#define LINEICON_BLUE				$00100000	; 青色フラグアイコン
	#define LINEICON_GREEN				$00200000	; 緑色フラグアイコン
	#define LINEICON_RED				$00400000	; 赤色フラグアイコン
	#define LINEICON_FORWARD			$00800000	; 前へ進むアイコン
	#define LINEICON_HELP				$01000000	; ヘルプアイコン
	#define LINEICON_INFORMATION		$02000000	; 情報アイコン
	#define LINEICON_KEY				$04000000	; 暗号化アイコン
	#define LINEICON_LOCK				$08000000	; ロックアイコン
	#define LINEICON_RECORD				$10000000	; 記録アイコン
	#define LINEICON_TICK				$20000000	; チェックアイコン
	#define LINEICON_TIPS				$40000000	; Tipsアイコン
	#define LINEICON_WARNING			$80000000	; 警告アイコン(コンパイルエラー時に是非)

	;***** 強調表示モード *****
	#define EMPFLAG_BOLD				$00000001	; 太字にする
	#define EMPFLAG_NON_CS				$00000002	; 大文字と小文字を区別しない
	#define EMPFLAG_HEAD				$00000004	; 頭にあるときのみ

	;***** エディタマーク表示、非表示の設定 *****
	#define EDM_HALF_SPACE				$00000001	; 半角スペースを表示するか
	#define EDM_FULL_SPACE				$00000002	; 全角スペースを表示するか
	#define EDM_TAB						$00000004	; タブマークを表示するか
	#define EDM_LINE					$00000008	; 改行マークを表示するか
	#define EDM_EOF						$00000010	; [EOF]マークを表示するか
	
	#define EDM_SHOW_ALL				$FFFFFFFF	; 全て表示する
	#define EDM_SHOW_NONE				$00000000	; 何も表示しない

	;***** 検索フラグ *****
	#define SEARCH_FROMCURSOR			$00000001	; 現在のカーソル位置から検索する
	#define SEARCH_BACK					$00000002	; 後ろ方向に検索処理を実行する
	#define SEARCH_REGEXP				$00000004	; 正規表現を利用する
	#define SEARCH_NOT_REFRESH			$00000008	; 検索結果を再描画しない
	#define SEARCH_BEEP_ON_404			$00000010	; 見つからなかったときにビープ音をならす
	#define SEARCH_NOT_ADJUST_VIEW		$00000020	; 見つかったときにキャレット位置へスクロールバーを追随させない

	;///////// 独立レベル /////////
	;***** ASCII記号用フラグ *****
	#define EMP_IND_PARENTHESIS			$00000001	; 前後に丸括弧()があることを許可する
	#define EMP_IND_BRACE				$00000002	; 前後に中括弧{}があることを許可する
	#define EMP_IND_ANGLE_BRACKET		$00000004	; 前後に山形括弧<>があることを許可する
	#define EMP_IND_SQUARE_BRACKET		$00000008	; 前後に各括弧[]があることを許可する
	#define EMP_IND_QUOTATION			$00000010	; 前後にコーテーション'"があることを許可する
	#define EMP_IND_UNDERBAR			$00000020	; 前後にアンダーバー_があることを許可する
	#define EMP_IND_OPERATORS			$00000040	; 前後に演算子 + - * / % ^ = があることを許可する
	#define EMP_IND_OTHER_ASCII_SIGN	$00000080	; 前述のものを除く全てのASCII記号 # ! $ & | \ @ ? , .
	
	; ASCII文字列を指定するフラグ
	#define EMP_IND_NUMBER				$00000100	; 前後に数字を許可する
	#define EMP_IND_CAPITAL_ALPHABET	$00000200	; 前後に大文字アルファベットを許可する
	#define EMP_IND_SMALL_ALPHABET		$00000400	; 前後に小文字アルファベットを許可する
	
	; 空白を指定するフラグ
	#define EMP_IND_SPACE				$00001000	; 前後に半角スペースを許可する
	#define EMP_IND_FULL_SPACE			$00002000	; 前後に全角スペースを許可する
	#define EMP_IND_TAB					$00004000	; 前後にタブを許可する

	; そのほかの文字列
	#define EMP_IND_JAPANESE			$00010000	; 日本語
	#define EMP_IND_KOREAN				$00020000	; 韓国語
	#define EMP_IND_EASTUROPE			$00040000	; 東ヨーロッパ
	#define EMP_IND_OTHERS				$80000000	; 上記以外

	; 省略形(主にこれらを使用すると指定が楽です)
	#define EMP_IND_ASCII_SIGN			$000000FF	; 全てのASCII記号列を許可する
	#define EMP_IND_ASCII_LETTER		$00000F00	; 全てのASCII文字を許可する(数字とアルファベット)
	#define EMP_IND_BLANKS				$0000F000	; 全ての空白文字列を許可する
	#define EMP_IND_OTHER_CHARSETS		$FFFF0000	; 全てのキャラクタセットを許可する
	#define EMP_IND_ALLOW_ALL			$FFFFFFFF	; 何でもOK

	;***** 折り返しモード *****
	#define LAPELFLAG_ALL				$FFFFFFFF	; 以下のフラグ全てを選択する
	#define LAPELFLAG_NONE				$00000000	; 何も有効にしない
	#define LAPELFLAG_WORDBREAK			$00000001	; 英文ワードラップ
	#define LAPELFLAG_JPN_PERIOD		$00000002	; 日本語の句読点に関する禁則処理
	#define LAPELFLAG_JPN_QUOTATION		$00000004	; 日本語のカギ括弧に関する禁則処理

	;***** 数値取得 (SetMetricsCod) *****
	#enum SM_LAPEL_COLUMN			=	0			; 折り返し位置(桁数)
	#enum SM_LAPEL_MODE								; 折り返しモード
	#enum SM_MARK_VISIBLE							; マークの表示状態
	#enum SM_LINENUM_WIDTH							; 左端の行番号の幅(ピクセル、-1でデフォルト)
	#enum SM_RULER_HEIGHT							; 上のルーラーの高さ(ピクセル、-1でデフォルト)

	;//////////////////////////////// 関数の宣言 ////////////////////////////////

	#uselib "Footy2.dll"

	;***** バージョン関連 *****
	#cfunc GetFooty2Ver "GetFooty2Ver"										; Footyのバージョンを取得する。
	#cfunc GetFooty2BetaVer "GetFooty2BetaVer"								; Footyのβバージョンを取得する。

	;***** ウィンドウ関連 *****
	#cfunc Footy2Create "Footy2Create" int,int,int,int,int,int				; Footyを作成する。
	#cfunc Footy2Delete "Footy2Delete" int									; 確保されたIDのデータを消去してメモリ領域を確保する。
	#cfunc Footy2Move "Footy2Move" int,int,int,int,int						; Footyウィンドウを移動する。
	#cfunc Footy2ChangeView "Footy2ChangeView" int,int						; ビューモードの変更
	#func  Footy2SetFocus "Footy2SetFocus" int,int							; フォーカス設定
	#cfunc Footy2GetWnd "Footy2GetWnd" int,int								; Footyのウィンドウハンドルを取得
	#cfunc Footy2GetWndVSplit "Footy2GetWndVSplit" int						; 縦分割用バーのウィンドウハンドルを取得
	#cfunc Footy2GetWndHSplit "Footy2GetWndHSplit" int						; 横分割用バーのウィンドウハンドルを取得
	#cfunc Footy2GetActiveView "Footy2GetActiveView" int					; アクティブなビューを取得
	#func  Footy2Refresh "Footy2Refresh" int								; 再描画処理

	;***** 編集系 *****
	#func  Footy2Copy "Footy2Copy" int										; クリップボードへコピー
	#func  Footy2Cut "Footy2Cut" int										; クリップボードへカット
	#func  Footy2Paste "Footy2Paste" int									; クリップボードからペースト
	#func  Footy2Undo "Footy2Undo" int										; アンドゥ
	#func  Footy2Redo "Footy2Redo" int										; リドゥ
	#cfunc Footy2IsEdited "Footy2IsEdited" int								; リドゥされているかどうか
	#func  Footy2SelectAll "Footy2SelectAll" int,int						; 全て選択
	#cfunc Footy2ShiftLock "Footy2ShiftLock" int,int						; シフトロックを行うかどうか
	#cfunc Footy2IsShiftLocked "Footy2IsShiftLocked" int					; シフトロックが行われているかどうか取得

	;***** 検索系 *****
	#define Footy2Search	Footy2SearchA									; エディタ検索機能
	#cfunc  Footy2SearchA "Footy2SearchA" int,sptr,int						; (ANSI版)
	#cfunc  Footy2SearchW "Footy2SearchW" int,wptr,int						; (UNICODE版)

	;***** ファイル編集 *****
	#func   Footy2CreateNew "Footy2CreateNew" int							; ファイルの新規作成
	#define Footy2TextFromFile	Footy2TextFromFileA							; テキストファイルからデータを読み込み
	#cfunc  Footy2TextFromFileA "Footy2TextFromFileA" int,sptr,int			; (ANSI版)
	#cfunc  Footy2TextFromFileW "Footy2TextFromFileW" int,wptr,int			; (UNICODE版)
	#define Footy2SaveToFile	Footy2SaveToFileA							; 現在のテキスト状態をファイルへの書き込み
	#cfunc  Footy2SaveToFileA "Footy2SaveToFileA" int,sptr,int,int			; (ANSI版)
	#cfunc  Footy2SaveToFileW "Footy2SaveToFileW" int,wptr,int,int			; (UNICODE版)
	#cfunc  Footy2GetCharSet "Footy2GetCharSet" int							; 文字コードセットを取得
	#cfunc  Footy2GetLineCode "Footy2GetLineCode" int						; 改行コードを取得

	;***** 文字列処理 *****
	#define Footy2SetSelText	Footy2SetSelTextA							; 選択文字列をセット
	#func   Footy2SetSelTextA "Footy2SetSelTextA" int,sptr					; (ANSI版)
	#func   Footy2SetSelTextW "Footy2SetSelTextW" int,wptr					; (UNICODE版)
	#define Footy2GetSelText	Footy2GetSelTextA							; 選択文字列を取得
	#cfunc  Footy2GetSelTextA "Footy2GetSelTextA" int,sptr,int,int			; (ANSI版)
	#cfunc  Footy2GetSelTextW "Footy2GetSelTextW" int,wptr,int,int			; (UNICODE版)
	#define Footy2SetText	Footy2SetTextA									; 文字列セット
	#func   Footy2SetTextA "Footy2SetTextA" int,sptr						; (ANSI版)
	#func   Footy2SetTextW "Footy2SetTextW" int,wptr						; (UNICODE版)
	#define Footy2GetTextLength	Footy2GetTextLengthA						; 文字列長さ取得
	#cfunc  Footy2GetTextLengthA "Footy2GetTextLengthA" int,int				; (ANSI版)
	#cfunc  Footy2GetTextLengthW "Footy2GetTextLengthW" int,int				; (UNICODE版)
	#define Footy2GetSelLength	Footy2GetSelLengthA							; 選択文字列長さを取得
	#cfunc  Footy2GetSelLengthA "Footy2GetSelLengthA" int,int				; (ANSI版)
	#cfunc  Footy2GetSelLengthW "Footy2GetSelLengthW" int,int				; (UNICODE版)
	#define Footy2GetText	Footy2GetTextA									; 文字列取得
	#cfunc  Footy2GetTextA "Footy2GetTextA" int,sptr,int,int				; (ANSI版)
	#cfunc  Footy2GetTextW "Footy2GetTextW" int,wptr,int,int				; (UNICODE版)
	#define Footy2GetLine	Footy2GetLineA									; 行データを取得
	#cfunc  Footy2GetLineA "Footy2GetLineA" int,sptr,int,int				; (ANSI版)
	#cfunc  Footy2GetLineW "Footy2GetLineW" int,wptr,int,int				; (UNICODE版)
	#define Footy2SetLine	Footy2SetLineA									; 行データを設定
	#func   Footy2SetLineA "Footy2SetLineA" int,int,sptr,int				; (ANSI版)
	#func   Footy2SetLineW "Footy2SetLineW" int,int,wptr,int				; (UNICODE版)
	#define Footy2GetLineLength	Footy2GetLineLengthA						; 行ごとの長さ取得
	#cfunc  Footy2GetLineLengthA "Footy2GetLineLengthA" int,int				; (ANSI版)
	#cfunc  Footy2GetLineLengthW "Footy2GetLineLengthW" int,int				; (UNICODE版)
	#cfunc  Footy2GetLines "Footy2GetLines" int								; 行の数を取得

	;***** キャレット・選択系 *****
	#cfunc  Footy2GetCaretPosition "Footy2GetCaretPosition" int,var,var		; 現在キャレットがある位置を取得
	#func   Footy2SetCaretPosition "Footy2SetCaretPosition" int,int,int,int	; 指定された位置へキャレットを移動する
	#cfunc  Footy2GetSel "Footy2GetSel" int,var,var,var,var					; 指定された選択状態を取得
	#func   Footy2SetSel "Footy2SetSel" int,int,int,int,int,int				; テキスト位置でのテキストを選択

	;***** 表示 *****
	#define Footy2AddEmphasis	Footy2AddEmphasisA							; 強調表示の文字を設定
	#func   Footy2AddEmphasisA "Footy2AddEmphasisA" int,sptr,sptr,int,int,int,int,int,int	; (ANSI版)
	#func   Footy2AddEmphasisW "Footy2AddEmphasisW" int,wptr,wptr,int,int,int,int,int,int	; (UNICODE版)
	#func   Footy2FlushEmphasis "Footy2FlushEmphasis" int					; 設定された色分け情報を適用
	#func   Footy2ClearEmphasis "Footy2ClearEmphasis" int					; 設定された色分け情報を全て破棄
	#func   Footy2SetFontSize "Footy2SetFontSize" int,int,int				; 全体のフォントのサイズを設定
	#define Footy2SetFontFace	Footy2SetFontFaceA							; 指定された種類のフォントを変更
	#func   Footy2SetFontFaceA "Footy2SetFontFaceA" int,int,sptr,int		; (ANSI版)
	#func   Footy2SetFontFaceW "Footy2SetFontFaceW" int,int,wptr,int		; (UNICODE版)
	#func   Footy2SetLineIcon "Footy2SetLineIcon" int,int,int,int			; 行アイコンを設定
	#cfunc  Footy2GetLineIcon "Footy2GetLineIcon" int,int,sptr				; 指定された行番号に設定されたアイコンを取得

	;***** 設定関連 *****
	#func   Footy2SetLapel "Footy2SetLapel" int,int,int,int					; 折り返しの設定
	#func   Footy2SetMetrics "Footy2SetMetrics" int,int,int,int				; Footyエディタコントロールの設定
	#cfunc  Footy2GetMetrics "Footy2GetMetrics" int,int,var					; Footy2GetMetrics関数などで設定した値を取得
	#func   Footy2SetColor "Footy2SetColor" int,int,int,int					; エディタの各部位の色を設定
	#cfunc  Footy2GetVisibleColumns "Footy2GetVisibleColumns" int,int		; 現在ビューで表示している桁数を取得
	#cfunc  Footy2GetVisibleLines "Footy2GetVisibleLines" int,int			; 現在ビューで表示している行数を取得

	;***** コールバック関数 (HSPから利用する場合は、hscallbk.dllが必要) *****
	#func   Footy2SetFuncFocus "Footy2SetFuncFocus" int,int,int,int
	#func   Footy2SetFuncMoveCaret "Footy2SetFuncMoveCaret" int,int,int,int
	#func   Footy2SetFuncTextModified "Footy2SetFuncTextModified" int,int,int
	#func   Footy2SetFuncInsertModeChanged "Footy2SetFuncInsertModeChanged" int,int,int

#endif
#endif
