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
${r"$*"}
