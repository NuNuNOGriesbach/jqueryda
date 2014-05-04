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
        else    
            $('body').css('font-size', 11)
            
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
        @heightsDefined = false
        @widthsDefined = false
        $(ret).removeClass('form')        
        def.firstSize = $('body').width()
        $(def.element).width('100%')
        
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
        @widthsDefined = true
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
       
    
    
    
    defineContainerHeights: (def, renderizer) ->
        @heightsDefined = true
        lineRenders = def.getLineRenders()
        groupRenders = def.getGroupRenders()
        pagerRenders = def.getPagerRenders()
        maxPage = null
                        
        for pager in pagerRenders            
            maxUsedHeight = 0
            if pager.element.children.length > 0
                for page in pager.element.children
                    usedHeight = page.getUsedHeight()
                    if usedHeight > maxUsedHeight
                        maxUsedHeight = usedHeight
                        maxBottom = page.getMaxBottom()
                        maxPage = page
                
            pager.element.setHeight(maxUsedHeight)
            if pager.element.getBottom() < maxBottom
                diff = maxBottom - maxUsedHeight - pager.element.getTop()
                pager.element.setHeight(diff)

        