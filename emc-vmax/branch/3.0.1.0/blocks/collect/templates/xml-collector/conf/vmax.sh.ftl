[#ftl]
#!/bin/sh
[#if symapi.path??]
export PATH=$PATH:${symapi.path}
[#else]
export PATH=$PATH:/opt/emc/SYMCLI/bin
[/#if]
[#if symapi.connect_type == 'remote']
export SYMCLI_CONNECT=${symapi.connect}
[/#if]
export SYMCLI_CONNECT_TYPE=${symapi.connect_type}

if `echo $* | grep -q "symmaskdb"` ; then     
   ${r"processid=$$"}
   ${r"$* 2>/dev/null 1>output.$processid.txt"}
   if [ ${r"$? -ne 0"} ]; then
      printf "<?xml version=\"1.0\" standalone=\"yes\" ?><SymCLI_ML></SymCLI_ML>";	      
   else      
	   ${r"cat output.$processid.txt"}
   fi
   rm -f "output.$processid.txt"
else
   ${r"$*"}
fi



