### Algoritmo de alinhamento para linhas justificadas.
 
###
class JustifyFieldsInBarAlgoritm

    constructor: () ->
        @processContainers = false
        
    ###
    Faz com que todos os elementos de uma Linha contenham tamanhos proporcionais de modo que todo o espaço util seja
    ocupado    
    ###
    run: (@def, specificRender, @renderizer, children, @screenElement, @methodToGetSizeScreen, @percentual) ->
        #Coloca os campos lado-a-lado e calcla o tamanho relativo total
        @_initialize()
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
        windowWidth = $(window).width()
        
        if windowWidth < 300
            @sizeScreen -= margin * 4
            
        else if windowWidth < 500
            @sizeScreen -= margin * 3
            
        else if windowWidth < 700
            @sizeScreen -= margin * 2
            
        else if windowWidth < 900
            @sizeScreen -= margin
        
        
                        
    _setNewSize: (element) ->
        @newSize = @sizeScreen
        element.setWidth @newSize
        
    _defineNewWidths: () ->
        for child in $('#' + @def.id).children()
            element = @renderizer.elements[child.id]
            if(element == undefined)
                continue
                
            @renderCount++             
            if !element.isContainer() or @processContainers
                
                @_setNewSize(element)
                @lastElement = element
                @elements.push(element)
            
    
        
        