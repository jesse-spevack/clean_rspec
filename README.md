# Clean RSpec
**A workshop on Ruby Testing Craftsmanship**

Testing has been a feature of the Ruby community for a long time. Why then are our spec files often so incomprehensible? In this workshop, I will share some ground rules for writing maintainable tests that will ensure that new teammates along with future-you can understand your test suite. We will use the RSpec testing framework to introduce several testing code-smells. For each smell, I will provide a demonstration on how to refactor the test along with time to practice for workshop participants. This workshop is geared towards anyone looking to hone their Ruby testing craft.

# Getting Started

Clone this repository, change directories to the project's root, and bundle install.

```bash
> git clone https://github.com/jesse-spevack/clean_rspec.git
> cd clean_rspec
> bundle install
```

We'll be sharing our work, so create your own git branch.

```bash
> git checkout -b $firstName
```

Next, create a [pull request](https://docs.github.com/en/github/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) to share your branch. I recommend the [github cli](https://cli.github.com/), which can be installed with `brew install gh`.

```bash
gh pr create --title "<First Name> Clean RSpeck"
```

Complete the **[Welcome Survey](https://forms.gle/ea3ixfw4tnQp8dAZ9)**.


# Running Tests

Run tests with the `rspec` command. See [documentation](https://relishapp.com/rspec).

```bash
> rspec
```

# References

This workshop is based off of the [Gilded Rose Refactoring Kata](https://github.com/NotMyself/GildedRose).

We are using a [Ruby translation](https://github.com/clayhill/Gilded-Rose-Refactoring-Kata) following the style from the amazing [Sandi Metz](https://sandimetz.com/) 2014 Railsconf talk, [All the Little Things](https://youtu.be/8bZh5LMaSmE).

# Workshop

The name for this workshop is a reference to [Clean Code: A Handbook of Agile Software Craftsmanship](https://www.goodreads.com/book/show/3735293-clean-code) by [Robert C. Martin](https://twitter.com/unclebobmartin), which describes the techniques and practices of writing code that is easy to read and change.

The goal of this workshop is to take some of the principles from *Clean Code* and apply them to writing tests with RSpec.

## Learning Outcomes
Participants will hone their understanding of writing clean tests by refactoring an example RSpec file. Through this exercise participants will be able to:

- Describe the purpose and benefits of testing
- Understand the concept of *object under test*
- Write tests that document code functionality
- Implement the *three-phase test pattern*
- Optimize for readability
- Use test doubles judiciously

## Agenda

| Topic                        | Time |
|------------------------------|------|
| Introduction                 | 0    |
| Why Testing                  | 5    |
| Setup                        | 10   |
| Unit vs Integration Tests    | 5    |
| Object Under Test            | 15   |
| 🍅 Break                      | 5    |
| Describe, Context, It        | 25   |
| Phases of Test               | 0    |
| Let Let! and Hooks           | 5    |
| Optimizing for Readability   | 10    |
| Mystery Guest                | 20   |
| Bad Names                    | 25   |
| 🍅 Break                       |      |
| Shared Examples and Contexts | 0    |
| Test Doubles                 | 5    |
|                              |      |

## Unit vs. Integration Test

Integration tests touch one end of a system and measure an output to assert that all the layers between the input and output are working. Filling out a form, clicking submit, and asserting that a widget is created in the database is an integration test.

Unit tests test one object or one method. Objects are black boxes with limited information. Unit tests should test return values, side effects, critical interactions, but not implementation details. 

Query - returns something, but changes nothing.

```ruby
def workshop_count
  @students.count
end
```

Command - returns nothing, but changes something.

```ruby
def enroll(student)
  @students << student
end
```

|          | Query             | Command           |
|----------|-------------------|-------------------|
| Incoming | Test return value | Test side effect  |
| Private  | Do not test       | Do not test       |
| Outgoing | Do not test       | Test message sent |

## Object Under Test

Object under test is the black box we are testing.

The subject keyword can be used to identify the system under test. [Stackoverflow](https://stackoverflow.com/questions/38437162/whats-the-difference-between-rspecs-subject-and-let-when-should-they-be-used) on `subject`.

```ruby
class Workshop
  # ...
end

# Bad
describe Workshop do
  it 'is instantiated by RSpec' do
    expect(subject).to be_a Workshop
  end
end

# Less Bad
describe Workshop do
  subject { Workshop.new }

  it 'is instantiated by RSpec' do
    expect(subject).to be_a Workshop
  end
end

# Good
describe Workshop do
  subject(:workshop) { Workshop.new }

  it 'is instantiated by RSpec' do
    expect(workshop).to be_a Workshop
  end
end
```

### You Do
Open `gilded_rose_spec.rb`. Improve the first test on [line 7](https://github.com/jesse-spevack/clean_rspec/blob/976459bd767d198ae053e0f9e057a4274a440c33/spec/gilded_rose_spec.rb#L7).

Commit your change.

```bash
git commit -m "object under test with subject keyword"
git push
```

If you have time, compare your work with other participants' pull requests.

## Describe, Context, It

Optimize for readability with RSpec documentation methods, `describe`, `context`, & `it`.

The `describe` method creates an example group. I recommend one describe block for each public method that the object under test implements.

```ruby
# Bad
RSpec.describe Workshop do
  # ...
end

# Good - use a `#` for instance methods
RSpec.describe Workshop do
  describe '#enroll' do
    # ...
  end
end

# Good - use a `.` for instance methods
RSpec.describe Workshop do
  describe '.create' do
    # ...
  end
end
```

Example groups can have examples.

```ruby
# Bad
RSpec.describe Workshop do
  describe '#enroll' do
    it 'enrolls' do
      # ...
    end
  end
end

# Good
RSpec.describe Workshop do
  describe '#enrolls' do
    it 'adds participant to workshop' do
      # ...
    end
  end
end
```

Example groups can have contexts with specific examples.

```ruby
# Bad
RSpec.describe Workshop do
  describe '#enroll' do
    it 'adds participant to workshop when there is room' do
      # ...
    end

    it 'does not add participant to workshop when there is not room' do
      # ...
    end
  end
end

# Good
RSpec.describe Workshop do
  describe '#enroll' do
    context 'when there is room' do
      it 'adds participant to workshop' do
        # ...
      end
    end

    context 'when there is NOT room' do
      it 'does not add participant to workshop' do
        # ...
      end
    end
  end
end
```

## Phases of test

Tests should have three phases: arrange, act, assert.

### Arrange

#### Let, Let!, Before

```ruby
# Lazy-evaluated
let(:gilded_rose) { GildedRose.new(name: 'Normal Item', days_remaining: 5, quality: 10) }

# Invoked before each example 
let(:gilded_rose) { GildedRose.new(name: 'Normal Item', days_remaining: 5, quality: 10) }

# Invoked before each example
before { gilded_rose.tick }
```

#### Setup

Setup the objects necessary for the test.

```ruby
# Bad
describe '#tick' do
  context 'when given a normal item' do
    it 'updates days remaining and quality' do
      gr = GildedRose.new(name: 'Normal Item', days_remaining: 5, quality: 10)
      gr2 = GildedRose.new(name: 'Sulfuras, Hand of Ragnaros', days_remaining: 5, quality: 10)
      # ...
    end
  end
end

# Less Bad
describe '#tick' do
  context 'when given a normal item' do
    it 'updates days remaining and quality' do
      gilded_rose = GildedRose.new(name: 'Normal Item', days_remaining: 5, quality: 10)
      # ...
    end
  end
end

# Good
describe '#tick' do
  context 'when given a normal item' do
    let(:gilded_rose) { GildedRose.new(...) }

    it 'updates days remaining and quality' do
      # ...
    end
  end
end

# Best 
describe '#tick' do
  subject(:gilded_rose) { described_class.new(name: name, days_remaining: days_remaining, quality: quality) }

  context 'when given a normal item' do
    let(:name) { 'Normal Item' }
    let(:days_remaining) { 0 }
    let(:quality) { 10 }

    it 'updates days remaining and quality' do
      # ...
    end
  end
end
```

### Act

Invoke the action that is being tested.

```ruby
describe '#tick' do
  # ...

  context 'when given a normal item' do
    # ...

    it 'updates days remaining and quality' do
      gilded_rose.tick
    end
  end
end
```

### Assert

Check the result of the action.

```ruby
# Bad
it 'normal item on sell date' do
  expect(gilded_rose).to be_instance_of(GildedRose)

  gilded_rose.tick

  expect(gilded_rose.days_remaining).to eq(-1)
  expect(gilded_rose.quality).to eq(8)
end

# Good
it 'normal item on sell date' do
  gilded_rose.tick

  expect(gilded_rose.days_remaining).to eq(-1)
  expect(gilded_rose.quality).to eq(8)
end

# Even Better
it 'normal item on sell date' do
  gilded_rose.tick

  expect(gilded_rose).to have_attributes(days_remaining: -1, quality: 8)
end
```
