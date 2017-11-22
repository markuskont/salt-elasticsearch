version=2

include={{ruledir}}/stdtypes.rb

rule=:%vhost:word% %src_ip:IPaddr% %ident:word% %auth:word% [%timestamp:char-to:]%] "%verb:word% %request:word% HTTP/%httpversion:float%" %response:number% %bytes:number% "%referrer:char-to:"%" "%agent:char-to:"%"%blob:rest%
