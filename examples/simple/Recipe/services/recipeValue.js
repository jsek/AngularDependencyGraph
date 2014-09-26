(function() {
    angular.module('recipe').value('recipeValue', {
        "recipeID": 1,
        "name": "Fish sticks and Rice",
        "price": 2.0,
        "time": 20,
        "image": "fishsticks-mine",
        "recipeIngredients": [
            {
                "recipeIngredientID": 1,
                "ingredient": {
                    "ingredientID": 1,
                    "name": "Fish sticks",
                    "Type": "fish"
                },
                "amount": 2.0,
                "amountType": "Portions of"
            }, {
                "recipeIngredientID": 2,
                "ingredient": {
                    "ingredientID": 2,
                    "name": "Rice",
                    "Type": "Pasta"
                },
                "amount": 2.0,
                "amountType": "Portions of"
            }, {
                "recipeIngredientID": 3,
                "ingredient": {
                    "ingredientID": 3,
                    "name": "Mayonaise",
                    "Type": "Condiment"
                },
                "amount": null,
                "amountType": null
            }, {
                "recipeIngredientID": 4,
                "ingredient": {
                    "ingredientID": 4,
                    "name": "Water",
                    "Type": "Condiment"
                },
                "amount": null,
                "amountType": null
            }, {

            }
        ],
        "recipeInstructions": [
            {
                "recipeInstructionID": 1,
                "instructionText": "Follow instructions on rice package to make rice"
            }, {
                "recipeInstructionID": 2,
                "instructionText": "Fry fish sticks"
            }, {
                "recipeInstructionID": 3,
                "instructionText": "Plate and serve with mayo"
            }
        ]

    });
})();