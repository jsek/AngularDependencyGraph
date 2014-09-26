(function () {
    angular.module('recipe').factory('httpRecipeServiceWithQ', ["$http", function ($http) {

        
        return {
            getRecipe: function (recipeId) {

                return $http.get('api/Recipes/' + recipeId);
                //return $http({ method: 'GET', url: 'api/Recipes/' + recipeId });
            },
            getRecipes: function () {
                return $http({ method: 'Get', url: 'api/Recipes' });
            }
        }
    }]);

})();