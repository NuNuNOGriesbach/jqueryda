class MessageRender extends SpecificElementRender
    constructor: (def) ->
        super(def)        
    
    createElement: (def, renderizer) ->
        ret = document.createElement('div')
        def.element = ret        
        
        
        def.specificRender = this
        ret
        
    