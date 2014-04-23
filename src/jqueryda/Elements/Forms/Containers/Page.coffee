class Page extends Form
    constructor: (@attribs) ->   
        super(@attribs)
        
    setLabel: (value) ->
        $(@obj_label).html(value)
        
    getLabel: (value) ->
        $(@obj_label).html()
        
    start: (renderizer) ->
        @specificRender?.beforeStartChildren(this, renderizer)
        super(renderizer)
        
    
    
