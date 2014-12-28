class FormRenderExt extends SpecificElementRender
    
    createElement: (def, renderizer) ->
                       
        ret = document.createElement('div')
                
        def.specificRender = this
        renderizer.addContainer(def)
        
        $(ret).attr('data-role','main')
        @element = def
        @component = ret
        #$(ret).height($('body').height())
        $(ret).addClass('ui-content')
        $(ret).addClass('jqm-content')
        
        def.setWidth('100%')
        
        $('body').addClass('noborder')
        
               
        ret
    
             
    beforeStartChildren: (def, renderizer) ->
        
        
    ajustRight: (element, maxRight, extra) ->
    
    startElement: (def, renderizer) ->
        lineRenders = def.getLineRenders()
        groupRenders = def.getGroupRenders()
        pagerRenders = def.getPagerRenders()
        
        for group in groupRenders
            group.afterFormStart?()
            
        for pager in pagerRenders
            pager.afterFormStart?()
            
        for line in lineRenders
            line.afterFormStart()
         
            
    realignElement: (def, renderizer) ->
        
    afterRealignChildren: (def, renderizer) ->
        
    afterRealignChildren: (def, renderizer) ->
        
    
    afterAllRealign: (def, renderizer) ->
        @startElement(def, renderizer)
        @afterAllStart(def, renderizer)    
    
    
    # Adiciona classes de marcação, de acordo com a posição e tipo de elemento
    markElements: (def, renderizer) ->
        last = def.children.length
        count = 0
        for child in def.children
            
            count++ 
            
            if count == 1
                $(child.component).attr("first",child.parent.type)
            else if count == last
                $(child.component).attr("last",child.parent.type)
            else
                $(child.component).attr("mid",child.parent.type)
            
            $(child.component).attr("in",child.parent.getContainerStyle())
        
    getWidth: (element, children, sizeScreen, componentsSizes, usedSize, renderCount) ->
        @lastElement = element
        
        if renderCount == children
            return (sizeScreen - usedSize) 
        Math.round (element.size * sizeScreen / componentsSizes) - 1
        
    defineContainerWidths: (def, renderizer) ->
       
       
    
    afterAllStart: (def, renderizer) ->
        $.mobile.initializePage()   
          
    defineContainerHeights: (def, renderizer) ->
      