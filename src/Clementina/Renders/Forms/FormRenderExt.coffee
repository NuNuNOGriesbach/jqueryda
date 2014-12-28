class FormRenderExt extends FormRender
    
    createElement: (def, renderizer) ->
        ret = super(def, renderizer)
        @element = def
        @component = ret
        #$(ret).height($('body').height())
        $('body').addClass('ui-widget-content')
        $('body').addClass('noborder')
        
        @defineEvents(def, renderizer)
        
        ret
    
    defineEvents: (def, renderizer) ->
        $(window).on('resize', (e) ->
            console.log('********EVENT: ', e)
            if e.target == window
                renderizer.realignElements()
                
        )
            
    startElement: (def, renderizer) ->
        ret = super(def, renderizer)
        
        if typeof(def.parentIfNotParent) != 'undefined' && def.parentIfNotParent != 'body'
            parent = $(def.parentIfNotParent)
            
            parentH = parent.getClientRects()['height']
            $(@component).height(parentH)
        else
            $(@component).height(screen.availHeight)
        $(@component).addClass('noborder')
        
        ret