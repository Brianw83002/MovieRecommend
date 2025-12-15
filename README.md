# Movie Recommend
Authors:
Beatriz Torres Archundia (btorre0@csu.fullerton.edu)
Hoang Ly (Hoangly1209@csu.fullerton.edu)
Francisco Preciado (Franciscop@csu.fullerton.edu)
Brian Williams (Brianw83002@csu.fullerton.edu)
## Background and motivation
With the advent of online streaming sites, consumers are left confused about which movie to watch. In such cases, the problem of decision fatigue arises, which can be a frustrating experience for consumers. The problem is most relevant when considering consumers with busy lifestyles, parents trying to choose a movie, or individuals seeking recommendations without much effort.
The need for MovieRecommend arises from the intention to simplify movie selection by developing a distinct, straightforward, and user-friendly mobile application that recommends movies based on the user's chosen genres. The application will help users make quicker decisions and enjoy entertainment in an efficient manner.
### Summary
MovieRecommend is an iOS mobile application developed using Swift and SwiftUI technology, which provides movie recommendations based on the genres chosen by the user. The application offers a straightforward interface that filters preferences and allows recommendations to be viewed individually.

## Features
Genre Selection Interface (Beatriz) - It enables users to select one or more movie genres through an interactive interface. The inputs for this feature are the genre preferences that the user selects, and the output will be a set of preferences used for generating recommendations. This functionality will be realized using buttons in SwiftUI and state variables to keep track of selected genres.
Movie Recommendation Generation (Beatriz) - This function provides a list of recommended movies based on a chosen genre. The inputs to this function include a list of chosen genres, and it will provide an output in the form of a filtered list of movies based on these genres.
Recommendation Navigation (Brian) - With this functionality, users can browse through recommended movies using the "Next" and "Previous" buttons. The inputs will include button clicks, and outputs will include the title of the movie being viewed. The above will be achieved through an index variable and control flow in Swift.
Empty-State and Error Handling (Francisco) - This functionality handles the case where no movies are matched based on the chosen genres, taking into consideration the situation where no matches are found. The inputs for this functionality include the output of the filter function, and outputs include a friendly message stating that no recommendations exist.
Movie Details View (Hoang) - A future enhancement may include a detailed view that displays additional information such as movie descriptions, ratings, or release year.


## Feature Assignment
Beatriz Torres Archundia: Genre selection interface, movie recommendation generation
Brian Williams: Recommendation navigation
Francisco: Empty-state and error handling
Hoang: UI refinement and testing


## Video:
https://youtube.com/shorts/rca02iwkkNU?si=AhETKVsZyphd47TV
