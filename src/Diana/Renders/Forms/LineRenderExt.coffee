class LineRenderExt extends SpecificElementRender
    
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
    
    _initializeAlgorithms: () ->
        
    _alignElements: (def, renderizer) ->
    
    _justify: (def, specificRender, renderizer, children, screenElement, methodToGetSizeScreen, percentual) ->        
        
        
    
    ## Renderiza as linhas com alinhamento Left ocupando apenas o espaço necessário para s campos
    _renderLeft: (def, renderizer, children) ->
    

    analizeHumanComfortableSize: (def, renderizer, children, trySize=null) ->        
                
    processSameRight: (def, renderizer, children) ->
    
    processGroups: (def, renderizer) ->
        

    defineContainerWidths: (def, renderizer) ->
  