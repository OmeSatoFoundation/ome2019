;	RPZ-Sensor Raspberry Pi module
#ifndef __rpz-gpio__
#define __rpz-gpio__

#include "hsp3dish.as"

	;	RPZ-Sensor用の拡張コマンドを定義するファイルです
	;	#include "rpz-gpio.as"
	;	を先頭に入れて使用してください
	;

#module
#deffunc gpmes str _p1

	;	gpmes "メッセージ"
	;	(簡易画面表示用)メッセージ更新
	;	update命令で画面更新する際のメッセージを設定します
	;
	_umsg=_p1
	return

#deffunc update int _p1

	;	update フレーム数
	;	(簡易画面表示用)フレーム更新
	;	フレーム数の値だけ、画面のフレーム更新を行います
	;	その際にgpmesで設定した文字列を表示します
	;
	fr=_p1
	if fr<=0 : fr=1
	repeat fr
	redraw 0
	pos 20,20
	mes _umsg
	redraw 1
	await 66
	loop
	return

#deffunc getnotestr var _p1, str _p2

	;	getnotestr 取得先変数, "検索文字列"
	;	noteselで指定した文字列バッファの中から
	;	"検索文字列"で指定した文字列で始まる行の内容を取得する
	;	結果は取得先変数に代入される
	;	該当文字列がなかった場合は""が代入される
	;
	s1=_p2				; 検索文字列
	s1len=strlen(s1)		; s1の長さ(byte)を取得
 	s1res=notefind(s1,1)		; s1で始まる行を検索
	if s1res<0 : _p1="" : return	; 該当行なし
	noteget s2,s1res		; 該当行を取得
	_p1=strmid(s2,s1len,255)	; 検索文字列以降を取得
	return

#deffunc geti2c

	;	geti2c
	;	rpz-sensorボードのI2C関連情報を取得する
	;	(rpz-sensorコマンドを使用、取得までラグがあります)
	;	以下の変数に結果が代入されます(すべて実数型になります)
	;	(温度) rpz_temp
	;	(気圧) rpz_pressure
	;	(湿度) rpz_humidity
	;	(照度) rpz_lux
	;
	exec "/home/pi/ome/bin/rpz-sensor >result.txt"
	notesel msg
	noteload "result.txt"		; result.txtを取り込む
	getnotestr res," Temp :"	; Tempの行内容をresに取得
	rpz_temp@=0.0+res
	getnotestr res," Pressure :"	; Pressureの行内容をresに取得
	rpz_pressure@=0.0+res
	getnotestr res," Humidity :"	; Humidityの行内容をresに取得
	rpz_humidity@=0.0+res
	getnotestr res," Lux :"		; Luxの行内容をresに取得
	rpz_lux@=0.0+res
	return 0

#deffunc init_bme int i2cch
  static_cal_dig_T1 = 0
  static_cal_dig_T2 = 0
  static_cal_dig_T3 = 0
  static_cal_dig_P1 = 0
  static_cal_dig_P2 = 0
  static_cal_dig_P3 = 0
  static_cal_dig_P4 = 0
  static_cal_dig_P5 = 0
  static_cal_dig_P6 = 0
  static_cal_dig_P7 = 0
  static_cal_dig_P8 = 0
  static_cal_dig_P9 = 0
  static_cal_dig_H1 = 0
  static_cal_dig_H2 = 0
  static_cal_dig_H3 = 0
  static_cal_dig_H4 = 0
  static_cal_dig_H5 = 0
  static_cal_dig_H6 = 0
  devcontrol "i2copen", 0x76, i2cch
  if stat : return 1

  ; *** get calibration data ***
  ; dig_T1
  devcontrol "i2cwrite", 0x88, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_T1 = stat

  ; dig_T2
  devcontrol "i2cwrite", 0x8A, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_T2 = get_signed16(stat)

  ; dig_T3
  devcontrol "i2cwrite", 0x8C, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_T3 = get_signed16(stat)

  ; dig_P1
  devcontrol "i2cwrite", 0x8E, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_P1 = stat

  ; dig_P2
  devcontrol "i2cwrite", 0x90, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_P2 = get_signed16(stat)

  ; dig_P3
  devcontrol "i2cwrite", 0x92, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_P3 = get_signed16(stat)

  ; dig_P4
  devcontrol "i2cwrite", 0x94, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_P4 = get_signed16(stat)

  ; dig_P5
  devcontrol "i2cwrite", 0x96, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_P5 = get_signed16(stat)

  ; dig_P6
  devcontrol "i2cwrite", 0x98, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_P6 = get_signed16(stat)

  ; dig_P7
  devcontrol "i2cwrite", 0x9A, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_P7 = get_signed16(stat)

  ; dig_P8
  devcontrol "i2cwrite", 0x9C, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_P8 = get_signed16(stat)

  ; dig_P9
  devcontrol "i2cwrite", 0x9E, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_P9 = get_signed16(stat)

  ; dig_H1
  devcontrol "i2cwrite", 0xA1, 1, i2cch
  if stat: return 1
  devcontrol "i2cread", i2cch
  static_cal_dig_H1 = stat

  ; dig_H2
  devcontrol "i2cwrite", 0xE1, 1, i2cch
  if stat: return 1
  devcontrol "i2creadw", i2cch
  static_cal_dig_H2 = get_signed16(stat)

  ; dig_H3
  devcontrol "i2cwrite", 0xE3, 1, i2cch
  if stat: return 1
  devcontrol "i2cread", i2cch
  static_cal_dig_H3 = stat

  devcontrol "i2cwrite", 0xE5, 1, i2cch
  if stat: return 1
  devcontrol "i2cread", i2cch
  h4h5lower = stat

  h4lower = (0x0F & h4h5lower)
  h5lower = (0xF0 & h4h5lower) >> 4

  ; dig_H4
  devcontrol "i2cwrite", 0xE4, 1, i2cch
  if stat : return 1
  devcontrol "i2cread", i2cch
  static_cal_dig_H4 = get_signed12((stat << 4) | h4lower))

  ; dig_H5
  devcontrol "i2cwrite", 0xE6, 1, i2cch
  if stat : return 1
  devcontrol "i2cread", i2cch
  static_cal_dig_H5 = get_signed12((stat << 4) | h5lower))

  ; dig_H6
  devcontrol "i2cwrite", 0xE7, 1, i2cch
  if stat : return 1
  devcontrol "i2cread", i2cch
  static_cal_dig_H6 = get_signed8(stat)

	return

#defcfunc get_signed16 int uint
  res = 0
  if uint>32767: res = uint-65536
  return res

#defcfunc get_signed8 int uint
  res = 0
  if uint>127: res = uint-256
  return res

#defcfunc get_signed12 int uint
  res = 0
  if uint>2047: res = uint-4096
  return res

#defcfunc force_bme int i2cch
  devcontrol "i2cwrite", 0x00F5, 2, i2cch
  if stat: return -1
  devcontrol "i2cwrite", 0x05F2, 2, i2cch
  if stat: return -1
  devcontrol "i2cwrite", 0xB5F4, 2, i2cch
  if stat: return -1

  ; read status
  ; wait for measuring is 0
  devcontrol "i2cwrite", 0xF3, 1, i2cch
  if stat : return -1
  devcontrol "i2cread", i2cch
  status = stat
  while (status & 0x08 != 0)
    devcontrol "i2cwrite", 0xF3, 1, i2cch
    if stat : return -1
    devcontrol "i2cread", i2cch
    status = stat
  wend

  dim data, 8

  ; TODO
  for 

#defcfunc get_temp int i2cch
	res = 0
	return res

#defcfunc get_humidity int i2cch
	res = 0
	return res

#defcfunc get_pressure int i2cch
	res = 0
	return res

#deffunc geti2c_lux_init

	;	geti2c_lux_init
	;	rpz-sensorボードの照度センサーを初期化します
	;	(最初の1回だけ実行してください、以降はgeti2c_luxで更新できます)
	;
	devcontrol "i2copen",0x39	; TSL2572を初期化
	if stat : return 1
	devcontrol "i2cwrite",0x0180,2	; 電源OFF
	if stat : return 1
	wait 40
	devcontrol "i2cwrite",0x0380,2	; 電源ON
	if stat : return 1
	wait 40
	return 0

#deffunc geti2c_lux

	;	geti2c_lux
	;	(照度) rpz_luxを高速に取得
	;
	devcontrol "i2cwrite",0x14+0x80,1
	devcontrol "i2creadw"
	rpz_lux@=0+stat			; 16bit整数でセンサー値を取得
	return

#global

	i2c_stat=0
	_umsg=""

#endif
