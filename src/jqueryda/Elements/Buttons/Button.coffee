class Button extends Element
    setValue: (value) ->
        $(@obj_field).val(value)
        
    getValue: (value) ->
        $(@obj_field).val()
        
    setLabel: (value) ->
        $(@obj_field).val(value)
        
    getLabel: (value) ->
        $(@obj_field).val()