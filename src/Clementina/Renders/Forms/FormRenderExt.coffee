class FormRenderExt extends FormRender
    
    createElement: (def, renderizer) ->
        ret = super(def, renderizer)
        @element = def
        @component = ret
        #$(ret).height($('body').height())
        $('body').addClass('ui-widget-content')
        $('body').addClass('noborder')
        $(window).on('resize', ->
            renderizer.realignElements()
            )
        ret
    
    startElement: (def, renderizer) ->
        ret = super(def, renderizer)
        $(@component).height(screen.availHeight)
        $(@component).addClass('noborder')
        
        ret