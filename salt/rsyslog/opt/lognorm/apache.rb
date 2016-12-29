version=2

include=/opt/lognorm/stdtypes.rb

#rule=:%vhost:word%
rule=: %vhost:word% %clientip:word% %ident:word% %auth:word% [%timestamp:char-to:]%] "%verb:word% %request:word% HTTP/%httpversion:float%" %response:number% %bytes:number% "%referrer:char-to:"%" "%user-agent:char-to:"%"%blob:rest%
