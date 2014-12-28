class TextFieldRender extends SpecificElementRender
    constructor: (def) ->
        super(def)
        @inputType = 'text'
    
    createElement: (def, renderizer) ->
        ret = document.createElement('div')
        def.obj_label = document.createElement('div')
        def.obj_field = document.createElement('input')
        
        def.obj_field.type = @inputType
        
        def.setLabel(def.label)
        def.setValue(def.value)
        
        $(def.label).addClass('label')
        $(def.obj_field).addClass('input')
        
        $(ret).append(def.obj_label)
        $(ret).append(def.obj_field)
        $(ret).addClass('field')
        
        #Possibilita que os campos estejam na mesma linha para calcular o padding, independente da largura...
        #Quado nem assim os campos de uma linha, estão na mesma linha, todos devem receber 100%
        $(def.obj_field).width($(def.obj_label).width() + 2)
        
        def.specificRender = this
        ret
        
    ajustRight: (def, maxRight, extra) ->    
        @conta = 0 if not @conta
        @conta++
        #console.log('ajustRight')
        
        right = def.getRight()
        width = def.getRealWidth()
        diffW = maxRight - right
        
        def.setWidth( width + diffW) if maxRight > right     
        @
        
    realignElement: (def, renderizer) ->
        
        #Possibilita que os campos estejam na mesma linha para calcular o padding, independente da largura...
        #Quado nem assim os campos de uma linha, estão na mesma linha, todos devem receber 100%
        def.setWidth(10)
    
    #atribui eventos ao elemento renderizado    
    bindEvent: (sender, def, eventName, functionName, container, sendList, serverEvent ) ->
        self=this
        $(def.obj_field).on(eventName, (e)->
            functionExec = functionName + '("' + sendList + '", "'+container+'","'+serverEvent+'");';
            try
                eval (functionExec)
            catch e
                alert('Execute ' + functionName + ': ' + e);
            
        )
        
    linkDefaults: (def, renderizer) ->
        console.log(def)
        @defineMaxLength(def, renderizer)
        @defineFormat(def, renderizer)
        
    defineMaxLength: (def, renderizer) ->
        if(!def.format)
            $(def.obj_field).attr('maxlength', def.size)
            
    defineFormat: (def, renderizer) ->
        
        if(!def.format)
            return;
           
        if !$(def.obj_field).mask
            
            library = 'js/jquery.maskedinput.min.js'
            if !config.jquerydaPath
                config.jquerydaPath = '/js/jqueryda/'
                
            renderizer.require(config.jquerydaPath + library, ()->
                console?.log('js/jquery.maskedinput.min.js carregada')
            )
        
        $(def.obj_field).mask(def.format)
        
        