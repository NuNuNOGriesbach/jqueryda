###
De acordo com a constante de conforto humano de cada elemento, garante que haverá
espaço suficiente para exibir o conteúdo de cada elemento.
Quando aplicado em Lines justificadas, pode causar overflow dos campos, o que resulta
em sua queda.
###
class HumanConfortableSizesAlgorithm

    run: (def, renderizer, children, trySize=null) ->
        size = 0
                
        for child in $('#' + def.id).children()
            element = $(child).element()
            if element == undefined
                continue
            element.equalizeRects()
            
            if(trySize)
                if element.getHumanConfort() < element.getHumanConfortLimit()                
                    $(child).element().setWidth(trySize)
                    
            if element.getHumanConfort() < element.getHumanConfortLimit()                
                $(child).element().ajustHumanConfortWidth()