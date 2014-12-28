class EventCommand
    constructor: (@parent) ->
    
    ###
    Recebe uma lista de error e instruções de tratamento para exibir ao usuário
    ###
    execute: (event) ->
        self = @
        $(window).load () -> 
            self.parent.render.elements[event.element].bindEvent(self.parent.sender, event.event, event.do, event.parent, event.send, event.server)
    
        
        
    