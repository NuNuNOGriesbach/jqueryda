class Form extends Element
    constructor: (@attribs) ->   
        @humanConfortLimit = 8.1
        super(@attribs)
        @lineRenders = []
        @barRenders = []
        @groupRenders = []
        @pagerRenders = []
        
    isElement: () ->
        true
        
    isField: () ->
        false    
        
    isContainer: () ->
        true
    
    #Estilo Bar: Elementos colocados um em baixo do outro
    #Estilo Line: Elementos colocados um ao lado do outro
    #Estilo Page: Elementos seguirão regras de outro container
    getContainerStyle: () ->
        'Bar'
    
    addLineRender: (lineRender) ->
        @lineRenders.push(lineRender)
        
    getLineRenders: () ->
        @lineRenders 
    
    addBarRender: (barRender) ->
        @barRenders.push(barRender)
        
    getBarRenders: () ->
        @barRenders 
    
    addGroupRender: (groupRender) ->
        @groupRenders.push(groupRender)
        
    getGroupRenders: () ->
        @groupRenders    
        
    addPagerRender: (pagerRender) ->
        @pagerRenders.push(pagerRender)
        
    getPagerRenders: () ->
        @pagerRenders    
        
    getInternalWidth: () ->
        @getRight()
        
    getPointsForWidth: (value) ->
        if @type!='Form'
            return super(value)
            
        if value.search?('%') > -1
            
            parentW = @getRealWidth()
            parentW = @firstSize if @firstSize
            @firstSize = parentW
                       
            return Math.round( parentW * value.substr(0,value.length - 1)  / 100)
        return value  
        
    #Número de caracteres que o elemento contém, normalmente igual ao definido na base de dados
    #Se não for definido um tamanho especifico para exibição, este valor será usado para calculos
    #de proporções
    getSize: () ->
        if @size
            return @size
        @_getMaxChildrenSize()    
        
    # Soma os getSizes() de todos os filhos, 
    # -> caso contenha linhas, retorna o getSize da maior linha.
    _getMaxChildrenSize: ()  ->
        lines = @getLineRenders()
        if(lines.length > 0)
            maxSize = 0
            for line in lines
                size = line.element.getSizeInScreen() * 1
                if size > maxSize
                    maxSize = size
            return maxSize
        bars = @getBarRenders()
        if(bars.length > 0)
            maxSize = 0
            for bar in bars
                size = bar.element.getSizeInScreen() * 1
                if size > maxSize
                    maxSize = size
            return maxSize
            
        maxSize = 0
        for child in @children
            maxSize += child.getSizeInScreen() * 1
        
        maxSize
        