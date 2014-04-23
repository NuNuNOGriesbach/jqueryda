class TextField extends Element
  
    constructor: (@attribs) ->        
        super (@attribs)
        if not @humanConfortLimit
            if @size > 250
                @humanConfortLimit = 1
            else if @size > 200
                @humanConfortLimit = 1.5
            else if @size > 150
                @humanConfortLimit = 2.5    
            else if @size > 100
                @humanConfortLimit = 3.1
            else if @size > 80
                @humanConfortLimit = 6.1
            
                
    
    setValue: (value) ->
        $(@obj_field).val(value)
        
    getValue: (value) ->
        $(@obj_field).val()
        
    setLabel: (value) ->
        $(@obj_label).html(value)
        
    getLabel: (value) ->
        $(@obj_label).html()
    
    
    setWidth: (value) ->        
        value = @getPointsForWidth(value)
        if @maxWidth and value > @maxWidth 
            value = @maxWidth 
            
        $(@obj_field).css('width', value)    
        try
            real = @getRealWidth()
            @diferenca = real - value
            $(@obj_field).css('width', value - @diferenca) 
            
        catch e
        try
            real = @getRealWidth()
            @diferenca = real - value
                        
        catch e
    
          
        
    setHeight: (value) ->
        $(@obj_field).css('height', value)
    
    #Largura no browser
    getRealWidth: () ->
        $(@obj_field).getClientRects()['width'] 

    #Calcula a proporção entre digitos exibiveis e largura do elemento.
    getHumanConfort: () ->
        @getRealWidth() / @getSize()
        
    #algumns elementos maniulam varios componentes, e esta função é chamada para ajustes entre eles
    equalizeRects: () -> 
        fieldw = $(@obj_field).getClientRects()['width'] 
        labelw = $(@obj_label).getClientRects()['width']
        
        if( labelw > fieldw )
            @setWidth(labelw)