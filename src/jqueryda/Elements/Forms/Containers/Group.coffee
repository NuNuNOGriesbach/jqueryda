class Group extends Form
    constructor: (@attribs) ->   
        super(@attribs)
        
    setLabel: (value) ->
        $(@obj_label).html(value)
        
    getLabel: (value) ->
        $(@obj_label).html()
        
    getPointsForWidth: (value) ->
        if value.search?('%') > -1
            parentW = @getParent().getWidth()
            return Math.round( parentW * value.substr(0,value.length - 1)  / 100)
            
        return value   
        
    getInternalWidth: () ->        
        @getRealWidth()
        
            
    start: (renderizer) ->
        @specificRender?.beforeStartChildren(this, renderizer)
        super(renderizer)
    
