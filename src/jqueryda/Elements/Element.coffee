class Element
    type = 'element'
    parentIfNotParent = 'body'
    
    constructor: (@attribs) ->        
        @diferenca = 0
        @children = []
        for attrib, value of @attribs
            @setAttribute attrib, value
        
                    
    setAttribute: (attrib, value) ->
        eval 'this.' + attrib + '= "' + value + '"'
        @attribs[attrib] = value
        
    getAttribute: (attrib) ->
        @attribs[attrib]
        
    addElement: (element) ->
        @children.push element
        element.parent = this
        
    isElement: () ->
        true
        
    isField: () ->
        false    
        
    isContainer: () ->
        false
    
    renderAttribs: (component) ->
        if @id
            $(component).attr('id', this.id)
        else
            $(component).attr('id', this.name)
            
        $(component).attr('name', this.name)
        for attrib, value of @attribs when attrib not in ['type','value','label','events']
            $(component).attr(attrib, value)
            
    #Ponto de customização das classes derivadas
    renderCustomAttribs: (component) ->
        
    render: (parent, renderizer) -> 
        if(!parent)
            if @parentIfNotParent
                parent = $(@parentIfNotParent)
            else
                parent = 'body'
            
        @component = renderizer.createElement(this)
        @renderAttribs(@component)
        @renderCustomAttribs(@component)
        
        for child in @children
            child.render(@component, renderizer)
            
        @setValue(@value) if @value
        
        $(parent).append?(@component)
    
    ## Local onde cada elemento pode adicionar jscripts especificos ou css...
    renderDependences: (parent, renderizer) -> 
        for child in @children
            child.renderDependences(@component, renderizer)
            
    start: (renderizer) ->        
        @specificRender?.beforeStartChildren?(this, renderizer)
            
        for child in @children
            child.start(renderizer)
        @specificRender?.afterStartChildren?(this, renderizer)    
        @specificRender?.startElement?(this, renderizer)
        
    afterAllStart: (renderizer) ->        
        for child in @children
            child.afterAllStart(renderizer)
        @specificRender?.afterAllStart(this, renderizer)    
         
    realign: (renderizer) ->        
        @specificRender?.beforeRealignChildren?(this, renderizer)
            
        for child in @children
            child.realign(renderizer)
        @specificRender?.afterRealignChildren?(this, renderizer)    
        @specificRender?.realignElement?(this, renderizer)
        
    afterAllRealign: (renderizer) ->        
        
        for child in @children
            child.afterAllRealign(renderizer)
        @specificRender?.afterAllRealign?(this, renderizer)     
        

    setValue: (value) ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.setValue) == 'function'
                return @specificRender.setValue(value)
        $(@component).val(value)
        
    getValue: (value) ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.getValue) == 'function'
                return @specificRender.getValue()
        $(@component).val()
        
    setLabel: (value) ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.setLabel) == 'function'
                return @specificRender.setLabel(value)
        $(@component).attr('label', value)
        
    getLabel: (value) ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.setLabel) == 'function'
                return @specificRender.setLabel(value)
        $(@component).attr('label')
       
    getPointsForWidth: (value) ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.getPointsForWidth) == 'function'
                return @specificRender.getPointsForWidth(value)
        if value.search?('%') > -1
            parentW = @getParent().getWidth()
            return Math.round( parentW * value.substr(0,value.length - 1)  / 100)
        return value
            
    setWidth: (value) ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.setWidth) == 'function'
                return @specificRender.setWidth(value)
                
        console.log('setWidth', this.id, value)
        value = @getPointsForWidth(value)
        if @maxWidth and value > @maxWidth 
            value = @maxWidth 
            
        $(@component).css('width', value)    
        #console.log('setWidth', this.id, value)
        try
            real = @getRealWidth()
            @diferenca = real - value
            $(@component).css('width', value - @diferenca) 
            
        catch e
            
    
    getWidth: () ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.getWidth) == 'function'
                return @specificRender.getWidth()
                
        ret = $(@component).css('width')  
        if ret.substr(-2) == 'px'
            ret = ret.substr(0, ret.length - 2)
        ret
        
    incWidth: (value) ->
        @setWidth(@getRealWidth()+value)
    
    decWidth: (value) ->
        @setWidth(@getRealWidth()-value)
    
    incHeight: (value) ->
        @setHeight(@getHeight()+value)
    
    decHeight: (value) ->
        @setHeight(@getHeight()-value)
  
    resetWidth: () ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.resetWidth) == 'function'
                return @specificRender.resetWidth()
        $(@component).css('width','initial')
        
    resetHeight: () ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.resetHeight) == 'function'
                return @specificRender.resetHeight()
        $(@component).css('height','initial')
        
    #Número de caracteres que o elemento contém, normalmente igual ao definido na base de dados
    #Se não for definido um tamanho especifico para exibição, este valor será usado para calculos
    #de proporções
    getSize: () ->
        @size
        
    setSize: (@size) ->
        @
    
    #Tamanho especifico (em número de caracteres) para exibição, este valor será usado para calculos
    #de proporções sobrepondo o tamanho real (definido com setSize)
    getSizeInScreen: () ->
        if(@sizeInScreen)
            return @sizeInScreen
        @getSize()
        
    setSizeInScreen: (@sizeInScreen) ->
        @
        
    setHeight: (value) ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.setHeight) == 'function'
                return @specificRender.setHeight(value)
        $(@component).css('height', value)
        try
            real = @getHeight()
            diferenca = real - value
            $(@component).css('height', value - diferenca) 
            
        catch e
        
    hidde: () ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.hidde) == 'function'
                return @specificRender.hidde()
        $(@component).hidde()
        
    show: () ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.show) == 'function'
                return @specificRender.show()
        $(@component).show()
    
    getPaddingRight: () ->  
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.getPaddingRight) == 'function'
                return @specificRender.getPaddingRight()
        ret = $(@component).css('padding-right')
        ret.substr(0, ret.lenght - 2) * 1
        
    getPaddingLeft: () ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.getPaddingLeft) == 'function'
                return @specificRender.getPaddingLeft()
        ret = $(@component).css('padding-left')
        ret.substr(0, ret.lenght - 2) * 1
        
    #Posição do ponto mais a direita
    getRight: () ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.getRight) == 'function'
                return @specificRender.getRight()
        $(@component).getClientRects()['right']
      
    getMaxRigth: () ->
        if @maxRigth
            return @$maxRigth()
        return parent.getMaxRigth()
        
    getClientRecOrZero: (key)->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.getClientRecOrZero) == 'function'
                return @specificRender.getClientRecOrZero(key)
        rect = $(@component).getClientRects()
        if rect and rect[key]
            return rect[key]
        return 0
    
    #Posição do ponto mais ao topo
    getTop: () ->
        @getClientRecOrZero('top')
        
    #Posição do ponto mais em baixo
    getBottom: () ->
        @getClientRecOrZero('bottom')   
        
    #altura
    getHeight: () ->
        @getClientRecOrZero('height')      
    
    #Posição do ponto mais ao topo
    getLeft: () ->
        @getClientRecOrZero('left')     
    
    #Largura no browser
    getRealWidth: () ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.getRealWidth) == 'function'
                return @specificRender.getRealWidth()
        try
            return $(@component).getClientRects()['width'] 
        catch e
            return $(@component).width()
    
    #Diferença entre o valor especificado para a largura e a largura renderizada pelo browser
    getExtraWidth: () ->
        @diferenca
    
    getParent: () ->        
        if(@parent?)
            return @parent
        null
    
    #Definição da razão mínima entre número de digitos que um componente pode exibir e a largura na tela, por padrão 8.1 pontos por dígito 
    #Alguns campos podem ter configurado errado seu número de digitos (normalmente por incopetencia de algum sobrinho metido a DBA) e pode
    #ser necessário reduzir este número
    getHumanConfortLimit: () ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.getHumanConfortLimit) == 'function'
                return @specificRender.getHumanConfortLimit()
        if @size  and @size<=5
            diff = 0.3
        else if @size  and @size<=5
            diff = 0.2
        else if @size  and @size>30
            diff = - 0.2
        else
            diff = 0
            
        if(@humanConfortLimit?)
            return @humanConfortLimit + diff
        return @getParent()?.getHumanConfortLimit() + diff
        
    #Calcula a proporção entre digitos exibiveis e largura do elemento.
    getHumanConfort: () ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.getHumanConfort) == 'function'
                return @specificRender.getHumanConfort()
        @getRealWidth() / @getSize()
    
    #define a largura para caber na proporcao de conforto humano especificada    
    ajustHumanConfortWidth: (sizeScreen) ->
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.ajustHumanConfortWidth) == 'function'
                return @specificRender.ajustHumanConfortWidth(sizeScreen)
        newSize = @getHumanConfortLimit() * @getSize()
        if(sizeScreen and newSize > sizeScreen)
            newSize = sizeScreen
        @setWidth(newSize)
    
    getSameRightElement: (first=null) ->
        if @sameRight
            if(!first)
                first = @sameRight
                
            element = $('#'+@sameRight).element()
            if element.sameRight 
                if element.sameRight != first
                    return element.getSameRightElement(first)
                                
            return element
        return null
            

    #algumns elementos maniulam varios componentes, e esta função é chamada para ajustes entre eles
    equalizeRects: () -> 
        if typeof(@specificRender)!='undefined'
            if typeof(@specificRender.equalizeRects) == 'function'
                return @specificRender.equalizeRects(sizeScreen)
        
    setInternalWidth: (@internalWidth) ->
    getInternalWidth: () ->
        @internalWidth
    
    #Repassa a responsabilidade de atribuir eventos para o renderizador (que conhece os elementos renderizados)    
    bindEvent: (sender, eventName, functionName, container, sendList, serverEvent ) ->
        @specificRender.bindEvent(sender, this, eventName, functionName, container, sendList, serverEvent)
        