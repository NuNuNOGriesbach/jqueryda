class TextFieldRender extends SpecificElementRender
    createElement: (def, renderizer) ->
        ret = document.createElement('div')
        def.obj_label = document.createElement('div')
        def.obj_field = document.createElement('input')
        
        def.obj_field.type='text'
        
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
        console.log('ajustRight')
        
        right = def.getRight()
        width = def.getRealWidth()
        diffW = maxRight - right
        
        def.setWidth( width + diffW) if maxRight > right     
        @