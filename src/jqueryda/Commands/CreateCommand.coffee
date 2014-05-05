class CreateCommand
    constructor: (@parent) ->
    
    ###
    Recebe uma lista de elementos e os cria cada um segundo sua classe. 
    Após criar cada elemento os envia para o renderizador, que fará as conexões de paternidade
    ###
    execute: (elements) ->
        for element, attribs of elements
            @create element, attribs
        render = @parent.render
        render.renderDependences()
        
        self = this
        setTimeout( ->
            self.linkEvents(elements)
        ,0)
        
        console.log('FUNCIONOU! se estiver antes dos senders')
        $(window).load () -> 
            render.render()
            render.defineContainerWidths(this)
            render.defineContainerHeights(this)
            render.startElements()
            
            
    create: (element, attribs)->
        instance = @getInstance(attribs.type, attribs)
        instance.name = element if not instance.name
        instance.id = element
        @parent.render.addElement element, instance
        
        
    getInstance: (type, attribs) ->
        eval 'ret = new ' + type + '(attribs);'
        ret
        
    linkEvents: (elements) ->
        for element, attribs of elements
            console.log('sender', element)