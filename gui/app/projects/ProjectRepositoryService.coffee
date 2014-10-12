class ProjectRepository extends Service
    
    constructor: ->
        
        # TODO: Load recent projects
        @projects = [
            { id: 1, name: 'Temp', path: 'C:\\Temp' }
            { id: 2, name: 'Example - Complex', path: 'D:\\Documents\\GitHub\\AngularDependencyGraph\\examples\\' }
        ]

    getProjects: -> @projects.slice()