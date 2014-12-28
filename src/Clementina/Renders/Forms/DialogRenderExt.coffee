class DialogRenderExt extends DialogRender
    startElement: (def, renderizer) ->
        super(def, renderizer)
        
        $('#' + def.id).dialog({ autoOpen: false, modal: true })
        @defineEvents(def, renderizer)
       
    
    open: (def, renderizer) ->
        
        $('#' + def.id).dialog({ autoOpen: false, modal: true })
        $('#' + def.id).dialog('open')
    
    close: (def, renderizer) ->
        $('#' + def.id).dialog('close')

    defineEvents: (def, renderizer) ->
        $(@component).on('dialogresizestart', ->
            console.log('Dialog resize')
        )
        $(@component).on('dialogclose', (event, ui)->
            def.onClose(renderizer,event, ui)            
        )
        $(@component).on('dialogopen', (event, ui)->
            def.onOpen(renderizer,event, ui)            
        )
        
    setWidth: (value) ->
        $(@component).dialog({ autoOpen: false, modal: true })
        $(@component).dialog( "option", "width", value );