class LineRender extends FormRender
            
    createElement: (def, renderizer) ->
        ret = document.createElement('div')
        $(ret).addClass('line')
        $(def.component).css('padding-left', def.margin)  if def.margin? > 0
        $(ret).css('width', '100%')
        def.specificRender = this
        renderizer.addContainer(def)
        def.parent.addLineRender(this)
        
        @element = def
        @component = ret
        ret
    
    afterFormStart: () ->
    
    startElement: (def, renderizer) ->
        ## Inicializa os algoritmos de alinhamento
        @_initializeAlgorithms()
        
        super(def, renderizer)
        
        @elements = []
        
        ## Adiciona o renderizador de linha para finalização do alinhamento (beforeFormStart)
        def.parent.addLineRender(this)
                
        $(def.component).css('padding-left', def.margin + 'px') if def.margin > -1
        
        @_alignElements(def, renderizer)
        
        @beforeFormStart = ->
            @processSameRight(def, renderizer,children)
        
        @
    
    _initializeAlgorithms: () ->
        @_algorithmJustify = new JustifyFieldsInLineAlgoritm()
        @_algorithmHumanConfortableSizes = new HumanConfortableSizesAlgorithm()
      
        
    _alignElements: (def, renderizer) ->
        children = $('#' + def.id).children().length
        if def.align == 'justify'            
            @_justify(def, this, renderizer, children, def.getParent(),'width',100)
        
        else if def.align == 'left'
            @_renderLeft(def, renderizer, children)
        else if def.align == 'pseudoJustify'
            @_renderLeft(def, renderizer, children)
            
            @afterFormStart = ->                 
                @_justify(def, this, renderizer, children, $('#' + def.justitfyElement).element(),'right',100)
                                
        else if def.align == 'pseudoJustifyHalf'
            @_renderLeft(def, renderizer, children)
            @afterFormStart = -> 
                @_justify(def, this, renderizer, children, $('#' + def.justitfyElement).element(),'right',50)
        else                        
            @analizeHumanComfortableSize(def, renderizer, children)
    
    _justify: (def, specificRender, renderizer, children, screenElement, methodToGetSizeScreen, percentual) ->        
        @_algorithmJustify.run(def, specificRender, renderizer, children, screenElement, methodToGetSizeScreen, percentual)
        
        
    
    ## Renderiza as linhas com alinhamento Left ocupando apenas o espaço necessário para s campos
    _renderLeft: (def, renderizer, children) ->
        @analizeHumanComfortableSize(def, renderizer, children)    


    analizeHumanComfortableSize: (def, renderizer, children, trySize=null) ->        
        @_algorithmHumanConfortableSizes.run(def, renderizer, children, trySize)
                
    processSameRight: (def, renderizer, children) ->
        for child in $('#' + def.id).children()
            element = $(child).element()

            same = element.getSameRightElement()
            if(same)     
                oldW = element.getWidth()
                diff = same.getRight() - element.getRight()
                element.setWidth(element.getRealWidth() + diff)
                extra = element.getExtraWidth()
                
                diff = same.getRight() - element.getRight() - extra
                element.setWidth(element.getRealWidth() + diff)
                @analizeHumanComfortableSize(def, renderizer, children, oldW)
    
    processGroups: (def, renderizer) ->
        

    defineContainerWidths: (def, renderizer) ->
        @_initializeAlgorithms()
        @_algorithmJustify.processContainers = true
        groupRenders = def.getGroupRenders()
        @_justify(def, this, renderizer, groupRenders.length, def.parent, 'width', 100)
    
    
            
                        
                
                
                
            
        