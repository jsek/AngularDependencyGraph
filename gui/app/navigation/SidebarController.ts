/// <reference path="../../../typings/angularjs/angular.d.ts"/>

class SidebarController {
    
    constructor(
        $scope: any, 
        mainViewService: MainViewService, 
        currentProjectService, 
        projectRepositoryService) {
        
        $scope.projects = projectRepositoryService.getProjects();

        mainViewService.on('change', (filename) => {
            $scope.currentView = filename;
        });
        
        $scope.goHome = () => {
            mainViewService.set('pages/intro.jade');
        };
        
        projectRepositoryService.on('add', (project) => {
            $scope.projects.push(project);
            $scope.$apply();
        });
        
        $scope.open = (projectId) => {
            var project = $scope.projects.find((x) => x.id === projectId);
            mainViewService.set('pages/project.jade');
            currentProjectService.set(project);
        };
            
        console.log('>> [Sidebar] loaded');
    }
}

angular.module('app')
.service('sidebarController', SidebarController);