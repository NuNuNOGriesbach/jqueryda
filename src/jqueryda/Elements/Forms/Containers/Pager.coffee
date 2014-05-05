class Pager extends Form
    constructor: (@attribs) ->   
        super(@attribs)
        @style = 'horizontal' if not @style
        
    start: (renderizer) ->
       @specificRender?.beforeStartChildren(this, renderizer)
       super(renderizer)    
        
    #Estilo Bar: Elementos colocados um em baixo do outro
    #Estilo Line: Elementos colocados um ao lado do outro
    #Estilo Page: Elementos seguirão regras de outro container
    getContainerStyle: () ->
        'Page'
        
    setHeigth: (height) ->
        for page in @children
            page.setHeight(height)            
        super(height)