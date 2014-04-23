#Modelo para renderizador especifico de elementos
class SpecificElementRender
    constructor: (def) ->
        
        
    createElement: (def, renderizer) ->
        document.createElement('div')
    
    ## Alguns elementos precisam ser inicializados, como TABs, accordions, etc...
    startElement: (def) ->


    #Evento que ocorre antes de executar o metodo start nos filhos de um continer
    #proprio para ajustes de tamanho e configurações do eemento pai
    beforeStartChildren: (def, renderizer) ->
    
    #Evento que ocorre depois de executar o metodo start nos filhos de um continer e antes do evento de start do próprio container
    #proprio para ajustes finos, e alinhamentos
    afterStartChildren: (def, renderizer) ->
    
    #Evento chamado após o start de todos os elementos, proprio para rotinas que tornam DIVs invisiveis e impedem o acesso
    #das propriedades metricas... por exemplo o metodo tabs() do jquery-ui
    afterAllStart: (def, renderizer) ->   