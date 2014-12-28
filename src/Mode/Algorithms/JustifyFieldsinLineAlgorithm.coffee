### Algoritmo de alinhamento para linhas justificadas.
 
###
class JustifyFieldsInLineAlgoritm

    constructor: () ->
        @processContainers = false
        
    ###
    Faz com que todos os elementos de uma Linha contenham tamanhos proporcionais de modo que todo o espaço util seja
    ocupado    
    ###
    run: (@def, specificRender, @renderizer, children, @screenElement, @methodToGetSizeScreen, @percentual) ->
        #Coloca os campos lado-a-lado e calcula o tamanho relativo total
        @_initialize()
        @_calculateComponentSizes('left')
        @_calculateSizeScreen()   
        @_removeMarginsOfScreenSize()
            
        @_defineNewWidths()
        
        specificRender.lastElement = @lastElements
        specificRender.elements = @elements
        
        
    _initialize: () ->
        @componentsSizes = 0
        @padding = 0
        @count = 0
        @usedSize = 0
        @expectedUsedSize = 0
        @renderCount = 0
        @lastElement = null
        @elements = []
        
    _calculateComponentSizes: (addClass) ->
        for child in $('#' + @def.id).children()
            @componentsSizes += $(child).element().getSizeInScreen() * 1
            $(child).addClass(addClass)
        
    _calculateSizeScreen: () ->
        if @methodToGetSizeScreen == 'width'
            @sizeScreen = Math.round(@screenElement.getRealWidth() * @percentual / 100)
        else
            @sizeScreen = Math.round(@screenElement.getRight()  * @percentual / 100)

    _removeMarginsOfScreenSize: () ->
        if(@def.children.length>0)
            #Garante que a margem esquerda será igual a direita
            margin = @def.children[0].getLeft() - @def.getParent().getLeft()
            @sizeScreen -= (margin * 2)
            
        ## Justes na força bruta para resolucoes estranhas
        windowWidth = $(window).width() * 1
        
        #console.log('screenSize', @sizeScreen, 'margin', margin)
        
        if windowWidth < 300
            @sizeScreen -= margin * 4
            
        else if windowWidth < 500
            @sizeScreen -= margin * 3
            
        else if windowWidth < 700
            @sizeScreen -= margin * 2
            
        else if windowWidth < 1000
            @sizeScreen -= margin * 0.5
        else if windowWidth < 1200
            @sizeScreen -= margin * 0.9
        
        
    _getJustifyWidth: (element, children, sizeScreen, componentsSizes, usedSize, renderCount) ->
        Math.round (element.getSizeInScreen() * sizeScreen / componentsSizes) 
    
    _calculateUsedSize: (element) ->
        if(@lastElement)
            @usedSize += (element.getRight() - @lastElement.getRight() )
        else
            @usedSize += element.getRealWidth()

        @expectedUsedSize += @newSize
        
    _distributeDifferencesInUsedSize: (element) ->
        if(@usedSize > @expectedUsedSize)
            diff =  (@usedSize - @expectedUsedSize)
            if(@lastElement)
                @lastElement.setWidth(@lastElement.getRealWidth() - (diff/2))
                element.setWidth @newSize - (diff/2)
            else
                element.setWidth @newSize - diff

            @usedSize = @expectedUsedSize
            
    _tryPreventOverflow: (element) ->
        if @renderCount == @children && @usedSize < @sizeScreen
            if(@lastElement && @lastElement.getTop() != element.getTop())
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
                        
    _setNewSize: (element) ->
        @newSize = @_getJustifyWidth(element, @children, @sizeScreen, @componentsSizes, @usedSize, @renderCount) 
        element.setWidth @newSize
        
    _defineNewWidths: () ->
        for child in $('#' + @def.id).children()
            element = @renderizer.elements[child.id]
            
            @renderCount++             
            if !element.isContainer() or @processContainers
                
                @_setNewSize(element)
                @_calculateUsedSize(element)
                @_distributeDifferencesInUsedSize(element)
                @_tryPreventOverflow(element)
                
                @lastElement = element
                @elements.push(element)
            
    
        
        