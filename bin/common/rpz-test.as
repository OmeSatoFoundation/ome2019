#ifndef __rpz-test__
#define __rpz-test__

#module

#deffunc testbme
i2c_ch_bme = 0
i2c_ch_tsl = 1

fail = init_bme(i2c_ch_bme)		; 温湿度気圧センサ bm280 を初期化する
if fail {				; 初期化成功チェック
  redraw  0
  mes "failed to init bme: " + fail
  redraw 1
  stop
}

temp = get_temp(i2c_ch_bme)		; 温度取得
hum  = get_humidity(i2c_ch_bme)		; 湿度取得
press= get_pressure(i2c_ch_bme)		; 気圧取得

; 取得したデータの表示
;mes "温度: " + temp + " [℃]"
;mes "湿度: " + hum  + " [%]"
;mes "気圧: " + press+ " [hPa]"
return


#deffunc testlux
init_lux i2c_ch_tsl			; 照度センサ tsl2572を初期化する
lux  = get_lux(i2c_ch_tsl)		; 照度取得
mes "照度: " + lux  + " [lx]"
return

#define testoled
oled "Good Morning,Good Bye,Good Afternoon"
return 

#define testspi
spiopen 0
data = getspi(0,0)
mes data
return 

#global

#endif