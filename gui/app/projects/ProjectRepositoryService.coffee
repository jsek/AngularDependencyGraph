fs = require('node-fs')

global.homeDir = process.env['USERPROFILE'] + '\\AngularDependencyGraph'
global.projectsDir = "#{global.homeDir}\\Projects\\"

class ProjectRepository extends Service
    
    _listeners = {}
    
    constructor: ->
        
        unless fs.existsSync global.projectsDir
            fs.mkdirSync global.homeDir
            fs.mkdirSync global.projectsDir
        
        @projects = []
        
        fs.readdir global.projectsDir, (err, files) =>
            if err?
                console.error err
            else
                for name in files
                    # dirty
                    if fs.existsSync (global.projectsDir + name)
                        @add(new Project name)

    getProjects: -> @projects.slice()
    
    add: (project) ->
        @projects.push project
        @trigger 'add', project
        console.log "New Project: #{project.name}"
        console.log _listeners

    trigger: (event, data) ->
        listener(data) for listener in _listeners[event]

    'on': (event, fn) ->
        _listeners[event] or= []
        _listeners[event].push fn 
        console.log 'Added new listener'