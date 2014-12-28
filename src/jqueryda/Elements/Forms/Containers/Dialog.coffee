class Dialog extends Form
    constructor: (@attribs) ->   
        super(@attribs)
        
    setLabel: (value) ->
        $(@obj_label).html(value)
        
    getLabel: (value) ->
        $(@obj_label).html()
        
    getPointsForWidth: (value) ->
                   
        return value   
        
    getInternalWidth: () ->        
        @getRealWidth()
        
            
    start: (renderizer) ->
        @specificRender?.beforeStartChildren(this, renderizer)
        super(renderizer)
        
    open: (renderizer) ->
        @specificRender?.open(this, renderizer)
    
    close: (renderizer) ->
        @specificRender?.close(this, renderizer)

    #eventos
    onClose: (renderizer,event, ui)->
    onOpen: (renderizer,event, ui)->