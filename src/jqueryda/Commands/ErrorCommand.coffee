class ErrorCommand
    constructor: (@parent) ->
    
    ###
    Recebe uma lista de error e instruções de tratamento para exibir ao usuário
    ###
    execute: (elements) ->
        @handler elements
        
            
            
    handler: (attribs)->
        console.log(attribs)
        parent.messageManager.addMessage(attribs['msg'], attribs['logo'], attribs['type'], attribs['trace'])
        
        
    