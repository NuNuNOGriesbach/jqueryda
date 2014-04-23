class InstanceManager
    InstanceManager.getInstance = (className, arg1, arg2, arg3) ->
        eval 'ret = new className(arg1,arg2,arg3)' 
        ret
        
    #Pelo nome da classe a ser renderizada, retorna um renderizador especifico extendido, um especifico ou um padrão
    #de acordo com a disponibilidade.
    #Convencionalmente, para extender sem sobrescrever um renderizador, usa-se o sufixo Ext
    InstanceManager.getInstanceOrDefault = (className, defaultClass='default', arg1, arg2, arg3) ->
        extClassName = className + 'Ext'
        
        eval 'if(typeof('+extClassName+')=="function"){
                ret = new '+extClassName+'(arg1,arg2,arg3); 
            }else if(typeof('+className+')=="function"){
                ret = new '+className+'(arg1,arg2,arg3); 
            }else{
                ret = new '+defaultClass+'(arg1,arg2,arg3);
            } ' 
        ret  
        
   