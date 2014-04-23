class LineRenderExt extends LineRender
    
    createElement: (def, renderizer) ->
        ret = super(def, renderizer)
        @element = def
        $(ret).addClass('ui-widget')
        ret
        
    