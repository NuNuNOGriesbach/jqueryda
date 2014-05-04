class Bar extends Form
    #Estilo Bar: Elementos colocados um em baixo do outro
    #Estilo Line: Elementos colocados um ao lado do outro
    #Estilo Page: Elementos seguirão regras de outro container
    getContainerStyle: () ->
        'Bar'

    _getMaxChildrenSize: ()  ->
        maxSize = 0
        for child in @children
             size = child.getSizeInScreen() * 1
             if size > maxSize
                maxSize = size
                
        maxSize