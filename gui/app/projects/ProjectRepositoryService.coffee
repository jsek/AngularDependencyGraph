class ProjectRepository extends Service
    
    constructor: ->
        
        # TODO: Load recent projects
        @projects = [
            new Project('Temp', 'C:\\Temp')
            new Project('Example - Complex', 'D:\\Documents\\GitHub\\AngularDependencyGraph\\examples\\', {
                files: '[complex/**/*.js]'
            })
        ]

    getProjects: -> @projects.slice()