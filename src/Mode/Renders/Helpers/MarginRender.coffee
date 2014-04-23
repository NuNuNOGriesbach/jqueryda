class MarginRender extends SpecificElementRender
    createElement: (def, renderizer) ->
        ret = document.createElement('div')
        def.component = ret
        $(ret).width(def.width)
        ret