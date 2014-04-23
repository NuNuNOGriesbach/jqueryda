class HorizontalTitle extends Element
    
    createComponent: (renderizer) ->
        ret = renderizer.createElement(this)
    
    setValue: (value) ->
        $(@component).html(value)
        
    