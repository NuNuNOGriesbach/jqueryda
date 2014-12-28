#Cada instancia do MessageManager gerencia  uma div invisivel onde são montadas 
#as mensagens para o usuario.
class MessageManager
    constructor: (@parent) ->        
        @renderElements()
        
    renderElements: () ->
        @create = new CreateCommand(@parent)
        @renderizer = @create.create('D1', {name: 'D1', type:'Dialog', width: '50%'})
        @create.create('D1txt', {id: 'D1txt', name: 'D1txt', type:'Line', parent: 'D1'})
        
        @renderizer.renderOne('D1')
        @renderizer.startElement('D1')
        
    addMessage: (text, img, type, stackTrace) ->
        component = document.getElementById('D1txt')
        txt = "<div class='"+type+"'><img src='"+img+"' style='width: 60px' align='left'/>"+text+"</div>"
        component.innerHTML += txt
        
        @renderizer.elements['D1'].onClose = (renderizer, event, ui) ->
            component = document.getElementById('D1txt')
            component.innerHTML = ""
            
        @renderizer.elements['D1'].open()
        @