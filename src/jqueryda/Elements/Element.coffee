class Element
    type = 'element'
    
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
        $(@component).val(value)
        
    getValue: (value) ->
        $(@component).val()
        
    setLabel: (value) ->
        $(@component).attr('label', value)
        
    getLabel: (value) ->
        $(@component).attr('label')
       
    getPointsForWidth: (value) ->
        if value.search?('%') > -1
            parentW = @getParent().getWidth()
            return Math.round( parentW * value.substr(0,value.length - 1)  / 100)
        return value
            
    setWidth: (value) ->
        #console.log('setWidth', this.id, value)
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
            
    
    getWidth: (value) ->
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
        $(@component).css('height', value)
        
    hidde: () ->
        $(@component).hidde()
        
    show: () ->
        $(@component).show()
    
    getPaddingRight: () ->        
        ret = $(@component).css('padding-right')
        ret.substr(0, ret.lenght - 2) * 1
        
    getPaddingLeft: () ->
        ret = $(@component).css('padding-left')
        ret.substr(0, ret.lenght - 2) * 1
        
    #Posição do ponto mais a direita
    getRight: () ->
        $(@component).getClientRects()['right']
      
    getMaxRigth: () ->
        if @maxRigth
            return @$maxRigth()
        return parent.getMaxRigth()
        
    #Posição do ponto mais ao topo
    getTop: () ->
        $(@component).getClientRects()['top'] 
        
    #Posição do ponto mais em baixo
    getBottom: () ->
        $(@component).getClientRects()['bottom']     
        
    #altura
    getHeight: () ->
        $(@component).getClientRects()['height']      
    
    #Posição do ponto mais ao topo
    getLeft: () ->
        $(@component).getClientRects()['left']     
    
    #Largura no browser
    getRealWidth: () ->
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
        if @size  and @size<=5
            diff = 0.2
        if @size  and @size>30
            diff = - 0.2
        else
            diff = 0
            
        if(@humanConfortLimit?)
            return @humanConfortLimit + diff
        return @getParent()?.getHumanConfortLimit() + diff
        
    #Calcula a proporção entre digitos exibiveis e largura do elemento.
    getHumanConfort: () ->
        @getRealWidth() / @getSize()
    
    #define a largura para caber na proporcao de conforto humano especificada    
    ajustHumanConfortWidth: (sizeScreen) ->
        
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
        
    setInternalWidth: (@internalWidth) ->
    getInternalWidth: () ->
        @internalWidth