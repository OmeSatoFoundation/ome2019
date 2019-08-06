#module
  voice_name = ""
  #deffunc jtalk str sentence
    if voice_name = "" {
      exec "jtalk.sh -w \"" + sentence + "\""
    }else{
      exec "jtalk.sh -w \"" + sentence + "\" -m \"" + voice_name + "\""
    }
    return

  #deffunc setvoice str _voice_name
    voice_name = "/home/pi/ome/bin/openjtalk/voices/" + _voice_name
    return
#global
