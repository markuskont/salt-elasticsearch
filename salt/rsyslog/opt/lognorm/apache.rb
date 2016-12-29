version=2

include=/opt/lognorm/stdtypes.rb

#rule=:%vhost:word%
rule=: %vhost:word% %src_ip:word% %ident:word% %auth:word% [%timestamp:char-to:]%] "%verb:word% %request:word% HTTP/%httpversion:float%" %response:number% %bytes:number% "%referrer:char-to:"%" "%agent:char-to:"%"%blob:rest%
