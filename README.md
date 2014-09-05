Dependencies:

  - ElasticSearch
  - Redis


Install it like any Rails application:

```
cd woodpecker
bundle install
rails s
```

To import your pictures:

```
bundle exec rake files:fetch[/absolute/path/to/your/image/folder]
```

There is a [demo application](http://woodpecker.phorque.it/)
    available. This demo has only a few thousands image, but
    woodpecker can easily store more than 1 million images.
