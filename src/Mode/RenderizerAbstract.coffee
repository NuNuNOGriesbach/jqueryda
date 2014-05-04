class RenderizerAbstract
    
    constructor: (@parent) ->
        @clear()
        self = @
        $.fn.element = (i) -> 
            id = @.get(0).id
            self.elements[id]

    addElement: (name, instance) ->        
        @elements[name] = instance
        @elements[instance.parent]?.addElement(instance) if instance.parent
        @roots.push(instance) if not instance.parent
    
    addContainer: (instance) ->
        @containers.push instance
        
    getElement : (name) ->
        @elements[name]
        
    getElements : () ->
        @elements
    
    clear: () ->
        @elements = {}
        @roots = []
        @containers = []
        @
        
    render: () ->
        for root in @roots
            root.render $('body'), this
            
    createElement: (def) ->
        specificRender = InstanceManager.getInstanceOrDefault(def.type + 'Render', 'SpecificElementRender', def)
        specificRender.createElement def, this        
        
    startElements: () ->
        for root in @roots
            root.start this
        
        for root in @roots
            root.afterAllStart this
            
    realignElements: () ->       
        for root in @roots
            root.realign this
        
        @defineContainerWidths()
        
        for root in @roots
            root.afterAllRealign this        
        
    renderDependences: () ->
        #@addCssFile('jquerida.css')
        for root in @roots
            root.renderDependences $('body'), this
            
    addCssFile: (cssFileName) ->
        cssFileName = '/js/zRender/css/' + cssFileName
        $('head').append('<link rel="stylesheet" href="'+cssFileName+'" type="text/css" />')
     
    #De acordo com as medidas da tela e janela, define o melhor tamanho de fonte
    configureFontSizes: () ->
        #$(document).css('font-size: 10px')
     
    #Evento chamado antes das rotinas de start do renderizador específico, que deve definir o tamanho final dos containers para o renderizador saber o espaço que pode ser utilizado
    # para renderização de campos e elementos
    defineContainerWidths: (createCommand) ->
        
        elements = 0
        for instance in @containers   
            instance.specificRender.markElements?(instance, this)        
            
            if instance.parent 
                if not instance.parent.specificRender.widthsDefined                
                    instance.parent.specificRender.defineContainerWidths(instance.parent, this)
            else
                instance.setWidth('100%')
                
        #@stop()
        console.log('RENDER_ABSTRACT: Larguras de containers definidas')
            
    #Evento chamado ao fim do processo, para que container renderizados lado-a-lado possam assumir a mesma altura   
    defineContainerHeights: (createCommand) ->
        elements = 0
        for instance in @containers   
            #console.log(instance.id, 'container')
            instance.specificRender.markElements?(instance, this)        
            
            if instance.parent                 
                if not instance.parent.specificRender.heightsDefined
                    instance.parent.specificRender.defineContainerHeights(instance.parent, this)
            else
                instance.setHeight('100%')
                
        #@stop()
        console.log('RENDER_ABSTRACT: Alturas de containers definidas')