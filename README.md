# Test app

This app download a set of recipes from a private hosts, it will show the recipes in a list. Each element in the list can be tapped to show the details in a separate screen.

## Requirements

    - Use Swift
    - Use Swift UI
    - Support iOS13+
    
## Features

    = The app will store the data into an internal database using Core Data 
    - The app will recover the stored data if the connection with the server is not possible

## Additional information

    - The app handle errors and responses with completition blocks and enumerations
    - All the calls are asyncronous
    - The manager to make the API calls is wrapped into a separate framework
    - MVVM design pattern applied following a SOLID approach
    - A unit test is present to check the parser of the object into the expected model
