# Reasoning

Built using ruby version 2.3.1 and rails 5.3.1 - the first rails app I've built in about 4 years.

## Breed Model
Pretty simple model here, just a name and a *has_and_belongs_to_many* relationship with the Tag model

## Tag model
Essentially the same as the Breed model

## Join Table
Since it is a many-to-many relationship between Breed <-> Tag there needed to be a join table of edges

# API Endpoints
I used the basic CRUD that was suggested [here](https://gist.github.com/dradford/bc7734953071bbaf7357174e4f36554e) - differing only in where I implemented the */breeds/:id/tags* endpoint in the BreedsController because I see it more acting on the Breed model than the Tag model.

## Regarding Conventions and Best Practices
Given more time to look into how to do things in ruby/rails there are a couple things I would have enjoyed changing:
1. Proper Serializers for each of the model types (breed, tag, stats)

    I'd prefer to have mixed in Serializers for each type rather than conversion functions that return hashes to be returned
2. Testing

    I would have liked to write legitimate unit tests for each method within the controllers, but given the timing I felt that integration-like tests are more important for ensuring functionality
3. Style

    I have no idea if this is written in correct rails/ruby style. Gladly I know that rails somewhat forces the programmer to follow a given directory structure.
