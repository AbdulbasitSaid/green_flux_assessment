# Green flux assessment

## Created Project structure, ApiClient, Repository, and Bloc

I have created the project structure to follow the Bloc architecture. This includes:
 The lib folder contains a features folder that contains the following:

1. Application Layer
   1. Presentation
      - Pages and Widgets
   1. Busines Logic(bloc)
      - State manages(blocs, events, and states)
2. Domain Layer
   - repository
3. Data Layer
   - models
   - API Client

I also wrote Unit tests for the models, ApiClient, Repository, and Blocs. all tests will be found in the test folder.

This project uses .env. you need to create the .env file from the .env.example file and update the API key.

## How it works

The project contains both app dependencies and dev dependencies. the following command ``flutter pub run build_runner --watch`` must be run to generate some needed files i.e model serializer. Before running the mentioned command you need to run ``flutter pub get`` to install all dependencies. to run all tests, run the following command ``flutter test`` to view test coverage following commands in other:

``flutter test --coverage``
then ``genhtml coverage/lcov.info -o coverage/html`` and finaly ``open coverage/html/index.html``

### Note: Make command can also be used in this project

 if you don't already use makefiles, run the following command first: ``brew install make`` this will install make util to your mac. but if you are on Linux no need. If you are on windows I suggest the first instructions on **How it works** or change to a mac or linux 😜.
 to initialize project run the following in the projects folder terminal:

    ```bash 
         make init
    ```
 The above command will install all the dependencies and the build runners.
 to run and view test you do run the following:

    ```bash 
        make test_coverage
    ```

### Note test coverage is low

On viewing the the test coverage, you will notice the coverage quite low. how ever crucial parts of the codebase base been tested. Also as import as Integration test is, no Integration test was written as it takes a lot of effort time write.

## final notes

I had fun working to this assessment. Also very good Api docs. I wish I had a UI UX design to work with. Thinking about the UI took most of my time 😁. Can't wait to get your feedbacks!🙈.
