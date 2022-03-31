# Book Reviews

Using the initial commit, implement the following feature. We are looking for a
well-tested, restful, solution following Rails best practices.

## Description

As a user, I want to be able to submit reviews on books that I have read. Each review should
consist of a required rating from 1 to 5 and an optional text description.

## Acceptance Criteria
* Review ratings are required and increment by whole numbers from 1 to 5
* Review descriptions are optional
* User should only be able to submit a single review per book
* Invalid review submissions should return descriptive errors.
* Add a separate endpoint to return all reviews for a given book.
    - Allow users to sort or filter by rating.
    - Allow users to filter for only reviews with descriptions.

## Stretch Goals
* Prevent users from submitting reviews containing the following fictional profanity: frak,
storms, gorram, nerfherder, crivens.
* Allow users to also submit reviews for Authors.
* Keep track of the average rating for each book.

# Dependencies

1. Ruby 2.7.3
2. Bundler 2.2.9
3. Rails 6.1.3
4. Postgres

# Installation

1. `bundle install`
2. `rake db:setup`

# Running the Specs
`rails spec` or `rspec spec`

# Start the Server
`rails s`
