class SenderAbstract
    constructor: (@parent) ->
        #console.log('sender iniciado')
        
    setSenderAction: (@url) ->
        
        
    triggerEvent: (sendList, container, serverEvent,def, caller, sender) ->
        destiny = '/' + @parent.config.module + '/' + @parent.config.controller + '/' + @parent.config.process;
        @data = {}
        @prepareDataToSend(sendList)
        
        events = {}
        events[container] = {}
        events[container][serverEvent] = {}
        
        post = {}
        post.events = JSON.stringify(events)
        post.values = JSON.stringify(@data)
        
        self = @
        $.ajax({
            url: destiny,
            type: "POST",
            cache: false,
            dataType: 'json',
            data: post,
            
        }).done((data, textStatus, jqXHR ) ->            
            self.receiveServerResponse(data, textStatus, jqXHR)
        ).fail( (jqXHR, textStatus, errorThrown) ->
            self.receiveServerError(jqXHR, textStatus, errorThrown)        
        );
            
    receiveServerResponse: (data, textStatus, jqXHR) ->
        @parent.process(data)
        
    receiveServerError: (data, textStatus, errorThrown) ->
        console.log('SERVER ERROR')
        console.log(data)
    
    prepareDataToSend: (sendList) ->
        if sendList=='*' || sendList=='' 
            return @getAllValues()
            
        elementsToSend = sendList.split(',')
        
    getAllValues: () ->
        for id, instance of @parent.render.elements
            @data[id] = instance.getValue() if not instance.isContainer()