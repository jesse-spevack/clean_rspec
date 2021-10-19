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
| Introduction                 | 5    |
| Learning Goals               | 5    |
| Why Testing                  | 5    |
| 🍅 Break 🍅                   | 5    |
| Unit vs Integration Tests    | 5    |
| Query vs Command             | 5    |
| Object Under Test            | 10   |
| Describe, Context, It        | 10   |
| 🍅 Break 🍅                   | 5    |
| 3 Phases: Arrange            | 10   |
| 3 Phases: Act & Assert       | 10   |
| Shared Examples              | 10   |
| 🍅 Break 🍅                   | 5    |
| Test Doubles                 | 10   |

## Unit vs. Integration Test

Integration tests touch one end of a system and measure an output to assert that all the layers between the input and output are working. Filling out a form, clicking submit, and asserting that a widget is created in the database is an integration test.

Unit tests test one object or one method. Objects are black boxes with limited information. Unit tests should test return values, side effects, critical interactions, but not implementation details. 

Query - returns something, but changes nothing.

```ruby
def workshop_count
  @participants.count
end
```

Command - returns nothing, but changes something.

```ruby
def enroll(participant)
  @participants << participant
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

### You Do
Open `gilded_rose_spec.rb`. Improve the test on [line 11](https://github.com/jesse-spevack/clean_rspec/blob/99837658e9a29f4b257165fea28f3a3d27c69cea/spec/gilded_rose_spec.rb#L11).

Commit your change.

```bash
git commit -m "describe, context, it"
git push
```

If you have time, compare your work with other participants' pull requests.


## Phases of test

Tests should have three phases: arrange, act, assert.

### Arrange

#### Let, Let!, Before

```ruby
# Lazy-evaluated
let(:gilded_rose) { GildedRose.new(name: 'Normal Item', days_remaining: 5, quality: 10) }

# Invoked before each example 
let!(:gilded_rose) { GildedRose.new(name: 'Normal Item', days_remaining: 5, quality: 10) }

# Invoked before each example
before { gilded_rose.tick }
```

#### Setup

Setup the objects necessary for the test.

```ruby
# Bad
describe '#enroll' do
  context 'when there is room' do
    it 'adds participant to workshop' do
      pr = Participant.new(name: 'Jesse') 
      pr2 = Participant.new(name: 'Sandi') 
      # ...
    end
  end
end

# Less Bad
describe '#enroll' do
  context 'when there is room' do
    it 'adds participant to workshop' do
      pr = Participant.new(name: 'Jesse') 
      # ...
    end
  end
end

# Good
describe '#enroll' do
  context 'when there is room' do
    let(:workshop) { Workshop.new(capacity: 1) }

    it 'adds participant to workshop' do
      # ...
    end
  end
end

# Best 
describe '#enroll' do
  subject(:workshop) { Workshop.new(capacity: capacity) }

  context 'when given a normal item' do
    let(:capacity) { 1 }

    it 'adds participant to workshop' do
      # ...
    end
  end
end
```

### You Do
Open `gilded_rose_spec.rb`. Add the arrange step the test on [line 11](https://github.com/jesse-spevack/clean_rspec/blob/99837658e9a29f4b257165fea28f3a3d27c69cea/spec/gilded_rose_spec.rb#L11).

Commit your change.

```bash
git commit -m "arrange"
git push
```

If you have time, compare your work with other participants' pull requests.

### Act

Invoke the action that is being tested.

```ruby
describe '#enroll' do
  # ...

  context 'when workshop has available seats' do
    # ...

    it 'adds participant' do
      workshop.enroll(participant)
    end
  end
end
```

### Assert

Check the result of the action.

```ruby
# Bad
subject(:workshop) { Workshop.new(seats: 15) }

let(:participant) { Participant.new('Jesse') }

it 'enrolls when there is room for participant' do
  expect(workshop).to be_instance_of(Workshop)

  workshop.enroll(participant)

  expect(workshop.participants.empty?).to eq false 
  expect(workshop.participants.count).to eq 1 
end

# Good
it 'adds participant' do
  workshop.enroll(participant)

  expect(workshop.participants.empty?).to eq false 
  expect(workshop.participants.count).to eq 1 
end

# Even Better
it 'adds participant' do
  workshop.enroll(participant)

  expect(workshop.participants.count).to eq 1 
end
```

### You Do
Open `gilded_rose_spec.rb`. Add the act and assert steps to the test on [line 11](https://github.com/jesse-spevack/clean_rspec/blob/99837658e9a29f4b257165fea28f3a3d27c69cea/spec/gilded_rose_spec.rb#L11).

Commit your change.

```bash
git commit -m "act and assert"
git push
```

If you have time, compare your work with other participants' pull requests.

## Shared Examples

Shared examples are optimized for the test writer. We spend far more time reading code than writing it, therefore tools that help us write code at the expense of making the code we write harder to read should be used with caution.

```ruby
# Bad
shared_examples :workshop do |seats, participant| 
  it 'enrolls' do
    workshop = Workshop.new(seats: seats)
    workshop.enroll(participant)
    expect(workshop.headcount).to eq 1
  end
end

it_behaves_like :workshop, 10, Participant.new('Jesse')


# Good
describe '#enroll' do
  subject(:workshop) { Workshop.new(capacity: capacity) }

  let(:participant) { Participant.new('Jesse') }

  context 'when workshop has available seats' do
    let(:capacity) { 1 }

    it 'adds participant' do
      workshop.enroll(participant)
    end
  end
end
```

### You Do
Open `gilded_rose_spec.rb`. Remove the shared example on [line 20](https://github.com/jesse-spevack/clean_rspec/blob/e56a9fd51db869e4d40b7d67b9ee73294d115e08/spec/gilded_rose_spec.rb#L20). Rewrite the tests starting on [line 58](https://github.com/jesse-spevack/clean_rspec/blob/e56a9fd51db869e4d40b7d67b9ee73294d115e08/spec/gilded_rose_spec.rb#L58), but optimize for readability.

Commit your change.

```bash
git commit -m "shared examples, hard pass"
git push
```

If it is hard to test, it is hard to use.