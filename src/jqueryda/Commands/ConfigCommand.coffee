class ConfigCommand
    constructor: (@parent) ->
    
    ###
    Recebe uma lista de variaveis/valor e adiciona na propriedade "global" de configuração
    ###
    execute: (config) ->
        for property, value of config
            @parent.config[property] = value
    
        
        
    