#module
  voice_name = ""
  #deffunc jtload str sentence, int idx, int mode
    output_path = "/tmp/jsay.wav"
    if voice_name = "" {
      exec "jtalk_synth.sh -o \"" + output_path + "\" -w \"" + sentence + "\""
    }else{
      exec "jtalk_synth.sh -o \"" + output_path + "\" -w \"" + sentence + "\" -m \"" + voice_name + "\""
    }
    mmload output_path, idx, mode
    return

  #deffunc setvoice str _voice_name
    voice_name = "/home/pi/ome/bin/openjtalk/voices/" + _voice_name
    return
#global
