# ETL

Basic toolkit for Extract/Transform/Load operations. Abstracts the details of
performing sourcing, intermediate structure generation and data persistance.

## Usage

### Sourcing

An ETL process is kicked off by configuring a process. For a basic CSV file
deserialize and bulk load:

```
process = Etl.create_process do |process|
  process.source.type = :csv
  process.source.location = 'samples/small.csv'
end

process.bootstrap
```

TODO: Write a strategy for HTTP, use JSON server

```
process = Etl.create_process do |process|
  process.source.type = :http
  process.source.location = 'localhost:8080/sample'
end

process.bootstrap
```

Strategies are available for CSV and JSON. If you need something else entirely,
a manual source can be used instead:

```
process = Etl.create_process do |process|
  process.source.type = :manual
  process.source.method = Proc.new do
    ...
  end
end
```

### Structure generation

Once data sourcing is complete, data can be fetched in-place.

```
process = Etl.create_process do |process|
  process.source.type = :csv
  process.source.location = 'samples/small.csv'
end

process.bootstrap
process.generate

process.generator.structures # intermediate structure for bulk import
```

If the data source is too large to process in memory, an iterator can be given 
instead:

```
process = Etl.create_process do |process|
  process.source.type = :csv
  process.source.location = 'samples/large.csv'
  process.generator.lazy = true
end

process.bootstrap
process.generator.start do |structures|
  ...
end
```

### Data persistance

Finally, once data is shaped the way you need it to, data can be persisted in
any kind of way you need it to. The receiver class is expected to respond to
`.create(args)`

```
process = Etl.create_process do |process|
  process.source.type = :csv
  process.source.location = 'samples/large.csv'
  process.store.type = Person # An active record model
end

process.bootstrap
process.generate
process.persist
```

In this way, any arbitrary store can be created,

```
class Payroll
  Struct.new(:target, :name, :last_name, ...)
  @@data = []

  def create(params = {})
    @@data << Struct::Target.new(name: params[:name], last_name: params[:last_name], ...)
  end
end

process = Etl.create_process do |process|
  process.source.type = :csv
  process.source.location = 'samples/small.csv'
  process.store.type = Payroll
end

process.bootstrap
process.generate
process.persist
```

## Development

...

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/etl.
