What's ?
===============
chef で使用する Maven の cookbook です。

Usage
-----
cookbook なので berkshelf で取ってきて使いましょう。

* Berksfile
```ruby
source "https://supermarket.chef.io"

cookbook "maven", git: "https://github.com/bageljp/cookbook-maven.git"
```

```
berks vendor
```

#### Role and Environment attributes

* sample_role.rb
```ruby
override_attributes(
  "maven" => {
    "user" => "user_name",
    "group" => "group_name"
  }
)
```

Recipes
----------

#### maven::default
指定したバージョンの Maven をインストール。

