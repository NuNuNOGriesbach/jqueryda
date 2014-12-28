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
        
        
        $(window).load () -> 
            render.render()
            render.defineContainerWidths(this)
            render.defineContainerHeights(this)
            render.startElements()
            setTimeout( ->
                self.linkEvents(elements)
            ,0)
            
            
    create: (element, attribs)->
        instance = @getInstance(attribs.type, attribs)
        instance.name = element if not instance.name
        instance.id = element
        @parent.render.addElement element, instance
        @parent.render
        
        
    getInstance: (type, attribs) ->
        eval 'ret = new ' + type + '(attribs);'
        ret
        
    #Espaco para mapear eventos nativos dos elementos, por exemplo o keyup para texts que so permitem numeros...    
    linkEvents: (elements) ->
        render = @parent.render
        console.log('linkando com', render)
        render.linkDefaulsInElements(elements)