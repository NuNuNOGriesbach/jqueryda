class DialogRender extends FormRender
            
    createElement: (def, renderizer) ->
        ret = document.createElement('div')
        $(ret).addClass('bar')
        $(def.component).css('padding-left', def.margin)  if def.margin? > 0
        
        def.specificRender = this
        renderizer.addContainer(def)
        
        @element = def
        @component = ret        
        ret
    
    afterFormStart: () ->