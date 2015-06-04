/// <reference path="../../../typings/angularjs/angular.d.ts"/>
/// <reference path="../../../typings/sweetalert/sweetalert.d.ts"/>

class Intro {
    constructor($scope: any,
        mainViewService) {

        $scope.title = "Angular Module Graph Generator"
        $scope.newProject = () => { mainViewService.set('pages/newProject.jade'); }
        $scope.importProject = () => { swal({ title: '!' }); };

        mainViewService.set('pages/intro.jade', $scope);

        console.log('>> [Intro] loaded');
    }
}

angular.module("app")
.service("introController", Intro);
