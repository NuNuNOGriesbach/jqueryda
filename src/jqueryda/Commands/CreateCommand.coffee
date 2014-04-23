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
        
        
        $(window).load () -> 
            render.render()
            render.defineContainerWidths(this)
            render.startElements()
            render.defineContainerHeights(this)
            
    create: (element, attribs)->
        instance = @getInstance(attribs.type, attribs)
        instance.name = element if not instance.name
        instance.id = element
        @parent.render.addElement element, instance
        
        
    getInstance: (type, attribs) ->
        eval 'ret = new ' + type + '(attribs);'
        ret