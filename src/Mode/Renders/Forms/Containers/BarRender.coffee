class BarRender extends FormRender
            
    createElement: (def, renderizer) ->
        ret = document.createElement('div')
        $(ret).addClass('bar')
        $(def.component).css('padding-left', def.margin)  if def.margin? > 0
        
        def.specificRender = this
        renderizer.addContainer(def)
        
        @element = ret
        ret
    
    afterFormStart: () ->
    
    startElement: (def, renderizer) ->
        super(def, renderizer)
        @processGroups(def, renderizer)
        @elements = []
        
        ## Adiciona o renderizador de linha para finalização do alinhamento
        def.parent.addLineRender(this)
                
        $(def.component).css('padding-left', def.margin + 'px') if def.margin > -1
                
        children = $('#' + def.id).children().length
        
        @beforeFormStart = ->
            @processSameRight(def, renderizer,children)
        
        if def.align == 'justify'            
            @renderJustify(def, renderizer, children, def.getParent(),'width',100)
        else if def.align == 'justifyMax'
            @renderJustifyMax(def, renderizer, children)
        else if def.align == 'left'
            @renderLeft(def, renderizer, children)
        else if def.align == 'pseudoJustify'
            @renderLeft(def, renderizer, children)
            @afterFormStart = -> 
                @renderJustify(def, renderizer, children, $('#' + def.justitfyElement).element(),'right',100)
                @analizeHumanComfortableSize(def, renderizer, children)
                #@renderPseudoJustify(def, renderizer, children)
        else if def.align == 'pseudoJustifyHalf'
            @renderLeft(def, renderizer, children)
            @afterFormStart = -> 
                @renderJustify(def, renderizer, children, $('#' + def.justitfyElement).element(),'right',50)
                @analizeHumanComfortableSize(def, renderizer, children)
                #@renderPseudoJustify(def, renderizer, children,2)
        
        @analizeHumanComfortableSize(def, renderizer, children)
        
        @
    
    getJustifyWidth: (element, children, sizeScreen, componentsSizes, usedSize, renderCount) ->
#        if renderCount == children
#            return (sizeScreen - usedSize)  
        console.log(element.id, 'size', element.size, 'screen', sizeScreen, 'componentSizes', componentsSizes)
        Math.round (element.size * sizeScreen / componentsSizes) 
        
    
    ## Renderiza as linhas com alinhamento Left ocupando apenas o espaço necessário para s campos
    renderLeft: (def, renderizer, children) ->
        sizeScreen = $(def.component).width()
        componentsSizes = 0
        count = 0
        
        for child in $('#' + def.id).children()
            componentsSizes += $(child).attr('size') * 1
            $(child).addClass('bottom')
            element = renderizer.elements[child.id]
            element.ajustHumanConfortWidth()    

    ## Renderiza as linhas justificadas ( ocupando todo o estaço da linha)    
    renderJustify: (def, renderizer, children, screenElement, method, percentual) ->
        
        #Coloca os campos lado-a-lado e calcla o tamanho relativo total
        componentsSizes = 0
        padding = 0
        for child in $('#' + def.id).children()
            componentsSizes += $(child).attr('size') * 1
            $(child).addClass('bottom')
              
        if method == 'width'
            sizeScreen = Math.round(screenElement.getRealWidth() * percentual / 100)
        else
            sizeScreen = Math.round(screenElement.getRight()  * percentual / 100)
            
        if(def.children.length>0)
            #Garante que a margem esquerda será igual a direita
            margin = def.children[0].getLeft() - def.getParent().getLeft()
            sizeScreen -= (margin * 2)
            
        ## Justes na força bruta para resolucoes estranhas
        windowWidth = $(window).width()
        
        if windowWidth < 300
            sizeScreen -= margin * 4
            
        else if windowWidth < 500
            sizeScreen -= margin * 3
            
        else if windowWidth < 700
            sizeScreen -= margin * 2
            
        else if windowWidth < 900
            sizeScreen -= margin
            
        
        
        count = 0
        usedSize = 0
        expectedUsedSize = 0
        renderCount = 0
        for child in $('#' + def.id).children()
            element = renderizer.elements[child.id]
            
            renderCount++ 
            element = renderizer.elements[child.id]
            if element.type != "Group"
                newSize = @getJustifyWidth(element, children, sizeScreen, componentsSizes, usedSize, renderCount) 
    
#                if element.id == 'ddd_celular'
#                    @stop()
                element.setWidth newSize
                
                if(@lastElement)
                    usedSize += (element.getRight() - @lastElement.getRight() )
                else
                    usedSize += element.getRealWidth()
                
                expectedUsedSize += newSize
                
                if(usedSize > expectedUsedSize)
                    diff =  (usedSize - expectedUsedSize)
                    if(@lastElement)
                        @lastElement.setWidth(@lastElement.getRealWidth() - (diff/2))
                        element.setWidth newSize - (diff/2)
                    else
                        element.setWidth newSize - diff
                    
                    usedSize = expectedUsedSize
                
                
                console.log('justify',element.id, 'newSize', newSize, 'realWidth', element.getRealWidth() , 'usedSize', usedSize, 'screenSize', sizeScreen)
                
                
                if renderCount == children
                    if(usedSize < sizeScreen)
                        
                        if(@lastElement && @lastElement.getTop() != element.getTop())
                            console.log(element.id, 'CAIU!!!!', sizeScreen - usedSize, 'used', usedSize, 'expect', expectedUsedSize, 'realWodth', element.getRealWidth() )
                            element.decWidth(1)
                            if @lastElement.getTop() != element.getTop()
                                for obj in @elements
                                    obj.decWidth(1)
                            if @lastElement.getTop() != element.getTop()
                                element.decWidth(1)
                            if @lastElement.getTop() != element.getTop()
                                for obj in @elements
                                    obj.decWidth(1)  
                            if @lastElement.getTop() != element.getTop()
                                element.decWidth(1)
                            if @lastElement.getTop() != element.getTop()
                                for obj in @elements
                                    obj.decWidth(1)         
                            
                        
                        
                
                
                @lastElement = element
                @elements.push(element)
                
            
                
    ## Renderiza as linhas pseudo-justificadas ( usando como tamanho de tela um elemento específico)    
    renderPseudoJustify: (def, renderizer, children,divisor=1) ->        
        sizeJustifyElement = $('#' + def.justitfyElement).element().getRight() / divisor
        componentsSizes = 0
        count = 0
        
        for child in $('#' + def.id).children()
            componentsSizes += $(child).attr('size') * 1
            $(child).addClass('left')
        
        usedSize = 0
        renderCount = 0
        for child in $('#' + def.id).children()
            renderCount++ 
            element = renderizer.elements[child.id]
            newSize = @getJustifyWidth(element, children, sizeJustifyElement, componentsSizes, usedSize, renderCount)
            newSize -= element.getExtraWidth()
            usedSize += newSize
            element.setWidth newSize    
        
        ##AJusta a diferença de cada browser
        erroAlign = element.getRight() -  sizeJustifyElement
        usedSize = 0
        renderCount = 0
        for child in $('#' + def.id).children()
            renderCount++ 
            element = renderizer.elements[child.id]
            newSize = @getJustifyWidth(element, children, sizeJustifyElement, componentsSizes, usedSize, renderCount)
            newSize -= element.getExtraWidth()
            usedSize += newSize
            element.setWidth newSize  
        
        @analizeHumanComfortableSize(def, renderizer, children)    
        
        
    
    analizeHumanComfortableSize: (def, renderizer, children, trySize=null) ->
        size = 0
                
        for child in $('#' + def.id).children()
            element = $(child).element()
            element.equalizeRects()
            
            if(trySize)
                if element.getHumanConfort() < element.getHumanConfortLimit()                
                    $(child).element().setWidth(trySize)
                    
            if element.getHumanConfort() < element.getHumanConfortLimit()                
                $(child).element().ajustHumanConfortWidth()
                
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
        
#        @groupRenders = def.getGroupRenders()
#        groups = @groupRenders.length
#        
#        size = 100 / (groups )
#        size = size + '%'
#        
#        for group in @groupRenders
#            group.element.setSize(groups)
#            group.element.setWidth(size)
            
            #console.log(@groupRenders,groups, size)
            #group.beforeFormStart?()
            
    defineContainerWidths: (def, renderizer) ->
        groupRenders = def.getGroupRenders()
        pagerRenders = def.getPagerRenders()
        
        groups = groupRenders.length
        count = 0
        totalPadding = 0
        if groups > 1
            for group in groupRenders
                if groupRenders[count+1]
                    $(groupRenders[count].element.component).addClass('left')
                    #espaço entre um grupo e outro
                    totalPadding += groupRenders[count+1].element.getLeft() - groupRenders[count].element.getRight()
                    count++
                    
            margin = groupRenders[0].element.getLeft() - def.parent.getLeft()
            console.log('margin',margin, 'tot', totalPadding)
            totalPadding += margin * 2
            
            #tamanho a ser removido de cada grupo
            diff = totalPadding / groups
            
        newSize = (Math.round(def.parent.getRealWidth() ) - totalPadding) / groups
           
        #Aplica o novo tamanho em todos os grupos da linha   
        totalSize = 0
        for group in groupRenders
            #group.element.setWidth(94.42 / groups + "%")
            
            #newSize = group.element.getRealWidth() - diff if not newSize
            
            group.element.setWidth(newSize)
            group.element.setInternalWidth(group.element.getRealWidth())
            lastGroup = group
            totalSize += newSize
            
        #verifica se existe diferença entre o tamanho ocupado e o disponivel, e aumenta o ultimo grupo se necessário
        if groups > 1
            availableSize = Math.round(def.parent.getRealWidth() ) - totalPadding
            if availableSize - totalSize != 0
                newSize = newSize + (availableSize - totalSize)
                lastGroup.element.setWidth(newSize)
                lastGroup.element.setInternalWidth(lastGroup.element.getRealWidth())
            
                        
                
                
                
            
        