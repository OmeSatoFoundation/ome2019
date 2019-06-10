#module

#deffunc getspi var _v1, int _p1, str _f1
	exec "/home/pi/ome/bin/spi "+_p1+" > "+_f1
	notesel msg
	noteload _f1
	getnotestr res,"data : "
	_v1=0.0+res
	return 0

#deffunc led int _p1, int _v1
	exec "/home/pi/ome/bin/led "+_p1+" "+_v1
	return 0

#deffunc oled str _s1
	;gpmes _s1
	update 1
	exec "/home/pi/ome/bin/./oled \""+_s1+"\""
	;gpmes "./oled \""+_s1+"\""
	return 0

#defcfunc rasp_map int _x, int _in_min, int _in_max, int _out_min, int _out_max
	_value=(_x - _in_min)*(_out_max - _out_min) / (_in_max - _in_min) + _out_min
	return _value

#global
