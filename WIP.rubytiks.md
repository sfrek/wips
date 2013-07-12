# Ruby tiks

### Build gem 

* In _OS_ command 

```
gem build <.gemspec file>
```

* Through _soure code_

```Ruby
# We need load .gemspec file
s = Gem::Specification.load("bosh_kvm_cpi.gemspec")
# Now, we create a Gem::Builder object
g = Gem::Builder.new(s)
# And then, we build the gem 
g.build
```
