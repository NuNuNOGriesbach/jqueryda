class TextFieldRenderExt extends TextFieldRender
    createElement: (def, renderizer) ->
        ret = super(def, renderizer)
        @element = def
        #$(ret).addClass('ui-widget-content')
        $(def.obj_field).addClass('ui-widget-input')
        
        
        ret
        
        