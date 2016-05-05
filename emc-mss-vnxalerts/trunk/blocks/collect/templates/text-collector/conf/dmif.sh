#!/bin/bash
NAS_DB=/nas /nas/bin/server_sysconfig server_2 -pci | egrep "(server_|cge-|Link:|fge-|fxg-)" | awk '{ if ( $3 == "IRQ:") { printf "%s",$0 } else { printf "%s\n",$0 } }'
NAS_DB=/nas /nas/bin/server_sysconfig server_3 -pci | egrep "(server_|cge-|Link:|fge-|fxg-)" | awk '{ if ( $3 == "IRQ:") { printf "%s",$0 } else { printf "%s\n",$0 } }'
NAS_DB=/nas /nas/bin/server_sysconfig server_4 -pci | egrep "(server_|cge-|Link:|fge-|fxg-)" | awk '{ if ( $3 == "IRQ:") { printf "%s",$0 } else { printf "%s\n",$0 } }'
NAS_DB=/nas /nas/bin/server_sysconfig server_5 -pci | egrep "(server_|cge-|Link:|fge-|fxg-)" | awk '{ if ( $3 == "IRQ:") { printf "%s",$0 } else { printf "%s\n",$0 } }'
NAS_DB=/nas /nas/bin/server_sysconfig server_6 -pci | egrep "(server_|cge-|Link:|fge-|fxg-)" | awk '{ if ( $3 == "IRQ:") { printf "%s",$0 } else { printf "%s\n",$0 } }'
NAS_DB=/nas /nas/bin/server_sysconfig server_7 -pci | egrep "(server_|cge-|Link:|fge-|fxg-)" | awk '{ if ( $3 == "IRQ:") { printf "%s",$0 } else { printf "%s\n",$0 } }'
NAS_DB=/nas /nas/bin/server_sysconfig server_8 -pci | egrep "(server_|cge-|Link:|fge-|fxg-)" | awk '{ if ( $3 == "IRQ:") { printf "%s",$0 } else { printf "%s\n",$0 } }'
NAS_DB=/nas /nas/bin/server_sysconfig server_9 -pci | egrep "(server_|cge-|Link:|fge-|fxg-)" | awk '{ if ( $3 == "IRQ:") { printf "%s",$0 } else { printf "%s\n",$0 } }'
exit 0
