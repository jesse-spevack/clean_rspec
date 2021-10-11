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

# Running Tests

Run tests with the `rspec` command. See [documentation](https://relishapp.com/rspec)

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
- Understand the concept of *system under test*
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
| System Under Test            | 15   |
| Describe, Context, It        | 25   |
| 🍅 Break                       |      |
| Phases of Test               | 0   |
| Optimizing for Readability   | 10    |
| Mystery Guest                | 20   |
| Bad Names                    | 25   |
| 🍅 Break                       |      |
| Shared Examples and Contexts | 0    |
| Test Doubles                 | 5    |
|                              |      |

## System Under Test

The subject keyword can be used to identify the system under test.

```ruby
class GildedRose
  # ...
end

# Bad
describe GildedRose do
  it 'is instantiated by RSpec' do
    expect(subject).to be_a GildedRose
  end
end

# Less Bad
describe GildedRose do
  subject { GildedRose.new }

  it 'is instantiated by RSpec' do
    expect(subject).to be_a GildedRose
  end
end

# Good
describe GildedRose do
  subject(:gilded_rose) { GildedRose.new }

  it 'is instantiated by RSpec' do
    expect(gilded_rose).to be_a GildedRose
  end
end
```

## Describe, Context, It

The `describe` method creates an example group.

```ruby
# Bad
RSpec.describe GildedRose do
  # ...
end

# Good
RSpec.describe GildedRose do
  describe '#tick' do
    # ...
  end
end
```

Example groups can have examples.

```ruby
# Bad
RSpec.describe GildedRose do
  describe '#tick' do
    it 'ticks' do
      # ...
    end
  end
end

# Good
RSpec.describe GildedRose do
  describe '#tick' do
    it 'updates days remaining and quality' do
      # ...
    end
  end
end
```

Example groups can have contexts with specific examples.

```ruby
# Bad
RSpec.describe GildedRose do
  describe '#tick' do
    it 'updates days remaining and quality for normal item' do
      # ...
    end

    it 'updates days remaining and quality for sulfuras item' do
      # ...
    end
  end
end

# Good
RSpec.describe GildedRose do
  describe '#tick' do
    context 'when given a normal item' do
      it 'updates days remaining and quality' do
        # ...
      end
    end

    context 'when given a sulfuras item' do
      it 'updates days remaining and quality' do
        # ...
      end
    end
  end
end
```

## Phases of test

Tests should have three phases: arrange, act, assert.

### Arrange

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
