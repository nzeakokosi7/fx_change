# first_ally_demo

A Flutter App DEMO challenge for First Ally.

A brief preview

Walk through            |  Adding account        | Converting currency
:-------------------------:|:-------------------------:|:-----
![](https://github.com/nzeakokosi7/fx_change/blob/master/assets/gifs/walk_through.gif)  |  ![](https://github.com/nzeakokosi7/fx_change/blob/master/assets/gifs/add_account.gif) | ![](https://github.com/nzeakokosi7/fx_change/blob/master/assets/gifs/convert_currency.gif)

## Getting Started
### Details of the project structure explained below

- /app <br/>
  <span style="font-size:15px; color:grey"> #This is where all the application's directories are contained. </span>
    - /core
        - /theme <br/>
          <span style="font-size:15px; color:grey"> #Here I created themes for my text widgets. </span>
        - /utils <br/>
          <span style="font-size:15px; color:grey">
      #Here you can I kept basic dart files (which are not necessarily widgets or models) </br>&nbsp;&nbsp;that run repetitive operations or tasks. </span>

    - /data 
      <br/>
      <span style="font-size:15px; color:grey">  # this directory is responsible for containing everything related to app data like models </br>&nbsp;&nbsp;and providers. </span>

        - /providers <br/>
        <span style="font-size:15px; color:grey">
        # Main data providers are contained here for api calls and shared preferences </span>
        
        - /models <br/>
        <span style="font-size:15px; color:grey">
        # Here you'd find data classes, or data models responsible for abstracting objects. </span>

    - /modules 
      <br/>
      <span style="font-size:15px; color:grey"> # Each module is a collection of related widgets which presents a unique feature </br>&nbsp;&nbsp; or provides a unique experience to the user.
  Each module consists of a page, </br>&nbsp;&nbsp; its respective GetXController and its custom widgets and in some cases its repository. </br>&nbsp;&nbsp;
  Here's an example <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  - /account_module <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  - account_screen.dart <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  - controller.dart <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  - repository.dart <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  - /widgets </br>&nbsp;&nbsp;&nbsp;&nbsp;
  The user interface design is kept in the screens with some level of abstraction, </br>&nbsp;&nbsp;&nbsp;&nbsp; thus the widgets which houses some reusable custom widgets which are used for the </br>&nbsp;&nbsp;&nbsp;&nbsp; respective module alone. </br>&nbsp;&nbsp;&nbsp;&nbsp;
  The controller is where all the respective user logic and interactions are handled and </br>&nbsp;&nbsp;&nbsp;&nbsp; controlled, every controller is initialized on app run by the "P.dart in app/core" which also </br>&nbsp;&nbsp;&nbsp;&nbsp; provides a global access interface to all controllers.
  </span>

    - /global_widgets
      <br/> <span style="font-size:15px; color:grey"> Widgets that can be reused by multiple **modules**. </span>

    - /services
      <br/> <span style="font-size:15px; color:grey"> This is where all app services are stored. </span>

- /routes </br>
  <span style="font-size:15px; color:grey"> #In this repository we I deposied all routes and pages. They're separated into two files,</br> and two classes, one being routes.dart, containing its constant routes and the other <br/> for routing. </span>
  - routes.dart
  This file contains all route constants ex:  
  class Routes { const HOME = '/ home'; }  
  - pages.dart
  This file contains the array routing ex :  
  class AppPages { static final pages = [  
  GetPage(name: Routes.HOME, page:()=> HomePage())
  ]};


- main.dart <br/>
  <span style="font-size:15px; color:grey">#main application file

