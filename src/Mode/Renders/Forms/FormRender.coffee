class FormRender extends SpecificElementRender
    createElement: (def, renderizer) ->
        ret = document.createElement('div')
        $(ret).addClass('form')
        
        def.specificRender = this
        renderizer.addContainer(def)
        ret
    
    beforeStartChildren: (def, renderizer) ->
        def.setWidth(def.width) if def.width
        
        
    ajustRight: (element, maxRight, extra) ->
        element.specificRender.ajustRight(element, maxRight, extra)    
    
    startElement: (def, renderizer) ->
        
        ## Justes na força bruta para resolucoes estranhas
        windowWidth = $(window).width()
        
        if windowWidth < 300
            
            $('body').css('font-size', 7)
        else if windowWidth < 500
            
            $('body').css('font-size', 8)    
        else if windowWidth < 700
            
            $('body').css('font-size', 9)
        else if windowWidth < 900
            
            $('body').css('font-size', 10)
        
        lineRenders = def.getLineRenders()
        groupRenders = def.getGroupRenders()
        pagerRenders = def.getPagerRenders()
        
        for group in groupRenders
            group.afterFormStart?()
            
        for pager in pagerRenders
            pager.afterFormStart?()
            
        for line in lineRenders
            line.afterFormStart()
            
#
#
#        lastElements = []
#        lastTop = 0
#        lastElement = null
#        for line in lineRenders
#            for element in line.elements
#                top = element.getTop()
#                if(lastTop != top)
#                    lastTop = top
#                    lastElements.push(lastElement) if lastElement
#                lastElement = element
#        
#        lastElements.push(lastElement) if lastElement
#                
#        maxRight = 0;
#        maxBottom = 0;
#        for endLine in lastElements when not endLine.sameRight
#            right = endLine.getRight()
#            bottom = endLine.getBottom()
#            if(right > maxRight)
#                maxRight = right
#                extra = element.getExtraWidth()
#            if(bottom > maxBottom)
#                maxBottom = bottom
#        
#        for group in groupRenders
#            right = group.element.getRight()
#            extraGroup = group.element.getExtraWidth()
#            if(right > maxRight)
#                maxRight = right
#                
#        def.maxRight = maxRight

    
    
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
        lineRenders = def.getLineRenders()
        groupRenders = def.getGroupRenders()
        pagerRenders = def.getPagerRenders()
        
        for group in groupRenders
            group.element.setWidth("94.42%")
            group.element.setInternalWidth(group.element.getRealWidth())
            
        for pager in pagerRenders
            pager.element.setWidth("94.42%")
            pager.element.setInternalWidth(pager.element.getRealWidth())
            
        for line in lineRenders
            line.element.setWidth("100%")    
            line.element.setInternalWidth(line.element.getRealWidth())
        