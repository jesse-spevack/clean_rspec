
# Learning Outcomes
Participants will hone their understanding of writing clean tests by refactoring an example RSpec file. Through this exercise participants will be able to:

- Describe the purpose and benefits of testing
- Understand the concept of *system under test*
- Write tests that document code functionality
- Implement the *three-phase test pattern*
- Optimize for readability
- Use test doubles judiciously

# Agenda
| Topic                        | Time |
|------------------------------|------|
| Introduction                 | 0    |
| Why Testing                  | 5    |
| Setup                        | 10   |
| System Under Test            | 15   |
| Describe, Context, It        | 25   |
| 🍅 Break                       |      |
| Optimizing for Readability   | 0    |
| Phases of Test               | 10   |
| Mystery Guest                | 20   |
| Bad Names                    | 25   |
| 🍅 Break                       |      |
| Shared Examples and Contexts | 0    |
| Test Doubles                 | 5    |
|                              |      |

# Outline

## Introduction
- Who am I?
- Who are you?
  - How many participants have less than 1 year professional coding experience?
  - How many participants have 1-3 years professional coding experience?
  - How many participants have 4-10 years professional coding experience?
  - How many participants have more than 10 years professional coding experience?
  - How many participants use RSpec as part of their job?
  - Fist to Five how confusing are the RSpec files you typically work in?
  - Fist to Five how tough is it to explain spec files to new folks joining your team?
- What are our goals?
  - Understand the purpose and benefits of testing
  - Write tests that document code functionality
  - Implement the 3-phase test pattern
  - Optimize tests for readability
  - Use test doubles judiciously
- How will this workshop run?
  - Simulate working with legacy business logic
  - I do, we do, you do pattern

## Why Testing
- First step to predict and measure behavior of code
- Documentation
- Find code smells

## TDD vs Testing
- Test driven development means starting with the test
  - benefit: focus on specific objective
- TDD story makes a lot of sense when working on new code
- TDD is tougher on legacy code - code that has already been written and may include some testing

## Setup
- Gilded Rose
  - Refactoring Kata
  - Roots in World of Warcraft, which I've never been addicted to
  - Kata is meant to help programmers practice refactoring
  - Sandi Metz "All the Little Things" Railsconf 2014
  - Our focus will be on refactoring the tests to illustrate some of the ideas I want to share
- visit [the workshop repo](https://github.com/jesse-spevack/clean_rspec)
- clone the project
- run bundle install
- run rspec
- look at the implementation and tests

## System Under Test
- System under test - the thing being tested for correct behavior
- RSpec gives us the `subject` keyword

## Describe, Context, It

## Optimizing for Readability

## Phases of Test
- `let` vs `let!`

## Mystery Guest

## Bad Names

## Shared Examples and Contexts

## Test Doubles